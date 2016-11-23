//
//  ViewController.swift
//  BanglaChat
//
//  Created by Md.Rasheduzzaman on 11/21/16.
//  Copyright © 2016 codertuts. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        view.backgroundColor = UIColor.orange
        
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
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

