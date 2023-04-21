//
//  LoadingScreenViewController.swift
//  Non-Persistent E2E Messaging
//
//  Created by Dylan Moran on 3/17/23.
//

import Foundation
import UIKit

class LoadingScreenViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var timer: Timer?
    
    //###################################################################################//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        login()
    }
    
    //###################################################################################//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(checkConnection), userInfo: nil, repeats: true)
    }
    
    //###################################################################################//
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
 
            timer?.invalidate()
            timer = nil
        }
    
    //###################################################################################//
    
    func login(){
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
            
            
            let mainVC = LoginViewController() // Replace with your main view controller class
            let navigationController = UINavigationController(rootViewController: mainVC)
            
            // Set the navigation controller as the root view controller after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if XMPPController.shared.xmppStream.isAuthenticated {
                    print("Already Connected")
                }
                else {
                    print("Automatically connecting to XMPP Server...")
                    XMPPController.shared.userJID = self.defaults.string(forKey: "savedUserJID")!
                    XMPPController.shared.password = self.defaults.string(forKey: "savedPassword")!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        XMPPController.shared.connect()
                    }
                }
            }
        }
    }
    
    //###################################################################################//
    
    @objc func checkConnection() {
        if XMPPController.shared.xmppStream.isAuthenticated {
            
            let mainVC = ChatsViewController() // Replace with your main view controller class
            let navigationController = UINavigationController(rootViewController: mainVC)

            // Set the navigation controller as the root view controller after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            
        }
       
    }
}
