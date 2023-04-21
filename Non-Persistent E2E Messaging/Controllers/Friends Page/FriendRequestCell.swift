//
//  FriendRequestCell.swift
//  Non-Persistent E2E Messaging
//
//  Created by Dylan Moran on 4/19/23.
//

import Foundation
import UIKit
import Combine

protocol FriendRequestTableViewCellDelegate: AnyObject {
    func denyButtonTapped(at index: Int, indexPath: IndexPath?)
}


class FriendRequestTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let acceptButton = UIButton(type: .system)
    
    weak var delegate: FriendRequestTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(acceptButton)
        acceptButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        acceptButton.setTitle("Accept", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    @objc func cellDenyButtonTapped() {
        delegate?.denyButtonTapped(at: tag, indexPath: getIndexPath())
    }

    private func getIndexPath() -> IndexPath? {
        var view = self.superview
        while view != nil && !(view is UITableView) {
            view = view?.superview
        }
        guard let tableView = view as? UITableView else {
            return nil
        }
        return tableView.indexPath(for: self)
    }


}


