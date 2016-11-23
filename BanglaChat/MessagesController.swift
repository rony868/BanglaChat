//
//  ViewController.swift
//  BanglaChat
//
//  Created by Md.Rasheduzzaman on 11/21/16.
//  Copyright © 2016 codertuts. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        checkIfUserIsLoggedIn()
        
    }
    
    func checkIfUserIsLoggedIn(){
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
        }else{
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
                }, withCancel: nil)
        }
        
    }
    
    func handleLogout(){
        do {
            try FIRAuth.auth()?.signOut()
        }catch let logoutError {
            print(logoutError)
            
        }
        
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
}

