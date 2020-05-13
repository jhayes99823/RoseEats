//
//  LoginPageViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginPageViewController: UIViewController {
    var showAppSegueID = "LoginPageSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           if Auth.auth().currentUser != nil{
               print("someone signed in already")
               self.performSegue(withIdentifier: self.showAppSegueID, sender: self)
           }
       }
}
