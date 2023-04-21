//
//  AdminPrototypeVC.swift
//  Non-Persistent E2E Messaging
//
//  Created by Dylan Moran on 3/8/23.
//

import UIKit

class AdminPrototypeVC: UIViewController {
    
    //Used to access default values
    let defaults = UserDefaults.standard

    //############################################################################################################################//
    //#                                                    Main Functions                                                        #//
    //############################################################################################################################//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        calibrateButtons()
        manageViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewLayout()
    }
    
    private let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    //Function to display elements on the screen

    //###################################################################################//
    
    func configureViewLayout(){
        scrollView.frame = view.bounds
        addFriendTextField.frame = CGRect(x: 30, y: 60, width: view.width-60, height: 52)
        addFriendButton.frame = CGRect(x: 30, y: addFriendTextField.bottom+15, width: addFriendTextField.width, height: addFriendTextField.height)
        logoutButton.frame = CGRect(x: scrollView.width/2-(scrollView.width/6), y: scrollView.height*0.775, width: scrollView.width/3, height: 52)

}
    
    //###################################################################################//
    
    //Adding elements to the view

    func manageViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(addFriendTextField)
        scrollView.addSubview(addFriendButton)
        scrollView.addSubview(logoutButton)
    }
    

    //###################################################################################//
    
    func calibrateButtons(){
        addFriendButton.addTarget(self, action: #selector(addFriendButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    //############################################################################################################################//
    //#                                                  Button Functions                                                        #//
    //############################################################################################################################//
    
    //Objective C code to determine what happens when login button is tapped
    
    @objc private func addFriendButtonTapped(){
        /*
        guard let username = addFriendTextField.text, !username.isEmpty else {
            print("Text field is empty.")
            return
        }
        
        XMPPController.shared.addFriend(name: username)
        print("Friend request sent to \(username)")
         */
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    //###################################################################################//
    
    //Sends user to the login screen and logs them out when log out button is tapped
    
    @objc private func logoutButtonTapped() {
        
        //resets all the deafult values for userJID and password to nil
        
        defaults.set(nil, forKey: "savedUserJID")
        defaults.set(nil, forKey: "savedPassword")
        
        //turns the flag for being "logged in" off
        
        defaults.set(false, forKey: "logged_in")
        
        XMPPController.shared.disconnectStream()
        
        //Loads the Login ViewController
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    //############################################################################################################################//
    //#                                                 Helper Functions                                                         #//
    //############################################################################################################################//
    
    
   
    //############################################################################################################################//
    //#                                                    UI Elements                                                           #//
    //############################################################################################################################//
    
    //Design of the Password Text Field
    
    private let addFriendTextField: UITextField = {
        
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "username"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    //###################################################################################//
    
    //Design of the Login Button
    
    private let addFriendButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Add New User", for: .normal)
        button.backgroundColor = .init(red: 0, green: 0.6, blue: 0.31, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    //###################################################################################//
    
    //Creates the element loginButton as a UI element to be used on the view
    
    private let logoutButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
   
}

//############################################################################################################################//
//#                                                     Extensions                                                           #//
//############################################################################################################################//


//############################################################################################################################//




