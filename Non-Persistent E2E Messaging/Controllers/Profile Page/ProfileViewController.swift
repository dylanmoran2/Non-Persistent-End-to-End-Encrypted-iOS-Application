//
//  ProfileViewController.swift
//  Non-Persistent E2E Messaging
//
//  Created by Dylan Moran on 3/27/23.
//

import Foundation
import SwiftUI
import UIKit
import XMPPFramework

class ProfileViewController: UIViewController{
    
    //############################################################################################################################//
    //#                                             Utilities and References                                                     #//
    //############################################################################################################################//
    
    //Allows access to default values
    let defaults = UserDefaults.standard
    
    var tableView = UITableView()
    
    var contentView = UIView()

    //############################################################################################################################//
    //#                                                    Main Functions                                                        #//
    //############################################################################################################################//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calibrateButtons()
        manageViews()
        setupNavBar()
    }
    
    //###################################################################################//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    //###################################################################################//
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //###################################################################################//
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewLayout()
    }
    
    //############################################################################################################################//
    //#                                              View Management Functions                                                   #//
    //############################################################################################################################//
    
    private let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //###################################################################################//
    
    func setupNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .default
        title = "Profile"
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // Change the title color
            .font: UIFont.systemFont(ofSize: 24) // Change the font size
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    //###################################################################################//
    
    func configureViewLayout() {
        let safeArea = view.safeAreaInsets
        let buttonWidth = view.width / 5
        let buttonHeight = buttonWidth
        let bottomMargin: CGFloat = 10

        scrollView.frame = view.bounds
        scrollView.contentInset.bottom = buttonHeight + bottomMargin * 2

        friendsButton.frame = CGRect(x: buttonWidth-(buttonWidth/4), y: view.height - (buttonHeight*2) - bottomMargin - safeArea.bottom, width: buttonWidth, height: buttonHeight)
        homeButton.frame = CGRect(x: friendsButton.right+(buttonWidth/4), y: view.height - (buttonHeight*2) - bottomMargin - safeArea.bottom, width: buttonWidth, height: buttonHeight)
        profileButton.frame = CGRect(x: homeButton.right+(buttonWidth/4), y: view.height - (buttonHeight*2) - bottomMargin - safeArea.bottom, width: buttonWidth, height: buttonHeight)
        
       
        let buttonsHeight = buttonHeight + bottomMargin + safeArea.bottom
        contentView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height - buttonsHeight - safeArea.top)
        
        profileCard.frame = CGRect(x: 0, y: contentView.height*0.1, width: contentView.width, height: contentView.height*0.6)
        
        displayName.frame = CGRect(x: profileCard.width*0.1, y: profileCard.height*0.5, width: profileCard.width*0.6, height: buttonHeight/2)
        presenceLabel.frame = CGRect(x: displayName.left, y: displayName.bottom+buttonHeight/3, width: profileCard.width*0.6, height: buttonHeight/2)
        
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toggleSwitch.centerYAnchor.constraint(equalTo: presenceLabel.centerYAnchor),
                toggleSwitch.leadingAnchor.constraint(equalTo: presenceLabel.trailingAnchor, constant: 8)
            ])
    }
    
    //###################################################################################//
    
    //Adding elements to the view

    func manageViews(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(homeButton)
        scrollView.addSubview(friendsButton)
        scrollView.addSubview(profileButton)
        scrollView.addSubview(settingsButton)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileCard)
        
        profileCard.addSubview(displayName)
        profileCard.addSubview(presenceLabel)
        profileCard.addSubview(toggleSwitch)
    }

    //###################################################################################//
    
    func calibrateButtons(){
        homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
        friendsButton.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        toggleSwitch.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
    }
    
    //###################################################################################//
    
    func setGradientBackground(){
        //let colorTop =  UIColor(red: 48.0/255.0, green: 24.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
        //let colorBottom = UIColor(red: 158.0/255.0, green: 140.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        let colorTop =  UIColor.white.cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    //############################################################################################################################//
    //#                                                  Button Functions                                                        #//
    //############################################################################################################################//
    
    @objc private func friendsButtonTapped(){
        let viewControllerToPresent = FriendsViewController()
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false, completion: nil)
        return
    }
    
    //###########################################################//
    
    @objc private func homeTapped() {
        let viewControllerToPresent = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false, completion: nil)
    }
    
    //###########################################################//
    
    @objc private func profileTapped(){
        let viewControllerToPresent = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false, completion: nil)
        return
    }
    
    //###########################################################//
    
    @objc private func settingsTapped(){
        
        let vc = AdminPrototypeVC()
        vc.title = "Controls"
        navigationController?.pushViewController(vc, animated: true)
        return
    }
    
    //###########################################################//
    
    @objc func toggleValueChanged(_ sender: UISwitch) {
        
        let boldFont = UIFont(name: "AvenirNext-Bold", size: 20)
        let regularFont = UIFont(name: "Avenir Next", size: 20)
        let attributedString = NSMutableAttributedString(string: "Presence: ", attributes: [NSAttributedString.Key.font: boldFont!])
        
        if sender.isOn {
            XMPPController.shared.myPresence = true
            defaults.set(true, forKey: "savedPresence")
            let presence = XMPPPresence(type: "available")
            XMPPController.shared.xmppStream.send(presence)
            profileCard.layer.borderColor = .init(red: 42/255, green: 204/255, blue: 37/255, alpha: 1.0)
            
            let presenceAttributedString = NSAttributedString(string: "    Online", attributes: [NSAttributedString.Key.font: regularFont!])
            attributedString.append(presenceAttributedString)
            presenceLabel.attributedText = attributedString
        } else {
            XMPPController.shared.myPresence = false
            defaults.set(false, forKey: "savedPresence")
            let presence = XMPPPresence(type: "unavailable")
            XMPPController.shared.xmppStream.send(presence)
            profileCard.layer.borderColor = UIColor.red.cgColor
            
            let presenceAttributedString = NSAttributedString(string: "    Away", attributes: [NSAttributedString.Key.font: regularFont!])
            attributedString.append(presenceAttributedString)
            presenceLabel.attributedText = attributedString
        }
    }

    
    //############################################################################################################################//
    //#                                                 Helper Functions                                                         #//
    //############################################################################################################################//
    
   
    //############################################################################################################################//
    //#                                                    UI Elements                                                           #//
    //############################################################################################################################//
   
    private let displayName: UILabel = {
        let name = UILabel()
        if let username = XMPPController.shared.xmppStream.myJID?.user?.capitalized {
            let boldFont = UIFont(name: "AvenirNext-Bold", size: 20)
            let regularFont = UIFont(name: "Avenir Next", size: 20)

            let attributedString = NSMutableAttributedString(string: "Username: ", attributes: [NSAttributedString.Key.font: boldFont!])
            let usernameAttributedString = NSAttributedString(string: "  \(username)", attributes: [NSAttributedString.Key.font: regularFont!])

            attributedString.append(usernameAttributedString)
            name.attributedText = attributedString
        } else {
            name.text = "Username not available"
        }
        name.textColor = .black
        return name
    }()
    
    private let presenceLabel: UILabel = {
        
        let label = UILabel()
        
        let boldFont = UIFont(name: "AvenirNext-Bold", size: 20)
        let regularFont = UIFont(name: "Avenir Next", size: 20)
        
        let attributedString = NSMutableAttributedString(string: "Presence: ", attributes: [NSAttributedString.Key.font: boldFont!])
        var presenceAttributedString = NSAttributedString(string: "Presence Unavailable", attributes: [NSAttributedString.Key.font: regularFont!])
        
        if XMPPController.shared.myPresence == true {
            presenceAttributedString = NSAttributedString(string: "    Online", attributes: [NSAttributedString.Key.font: regularFont!])
        }
        else {
            presenceAttributedString = NSAttributedString(string: "    Away", attributes: [NSAttributedString.Key.font: regularFont!])
        }
        attributedString.append(presenceAttributedString)
        label.attributedText = attributedString
        
        return label
    }()
    
    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemBlue
        toggle.isOn = XMPPController.shared.myPresence
        return toggle
    }()
    
    private let homeButton: UIButton = {
        
        let button = UIButton()
    
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .comment), for: .normal)
        button.backgroundColor = .init(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.4)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = .init(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.4)
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    //###################################################################################//
    
    private let friendsButton: UIButton = {
        
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .users), for: .normal)
        button.backgroundColor = .init(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = .init(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.4)
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    //###################################################################################//
    
    private let profileButton: UIButton = {
        
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .user), for: .normal)
        button.backgroundColor = .init(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 5
        button.layer.borderColor = .init(red: 42/255, green: 204/255, blue: 37/255, alpha: 1.0)
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    //###################################################################################//
    
    private let settingsButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .bottom
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0)
        return button
    }()
    
    private let profileCard: UIView = {
        
        let card = UIView()
        
        card.backgroundColor = .white
        card.layer.cornerRadius = 20
        card.layer.borderWidth = 5
        if XMPPController.shared.myPresence == true {
            card.layer.borderColor = .init(red: 42/255, green: 204/255, blue: 37/255, alpha: 1.0)
        }
        else {
            card.layer.borderColor = UIColor.red.cgColor
        }
        
        return card
        
    }()
    

}

//############################################################################################################################//
//#                                                     Extensions                                                           #//
//############################################################################################################################//


//############################################################################################################################//
