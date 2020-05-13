//
//  SecondViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var authListenerHandle: AuthStateDidChangeListenerHandle!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBAction func pressedSignOutButton(_ sender: Any) {
        do { try Auth.auth().signOut() } catch {
            print("sign out error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authListenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if (Auth.auth().currentUser == nil) {
                print("go to login oage")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("toure signin in")
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(authListenerHandle)
    }
}

