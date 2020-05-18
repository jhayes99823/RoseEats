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
import Rosefire

class LoginPageViewController: UIViewController {
    var showAppSegueID = "LoginPageSegue"
    let REGISTRY_TOKEN = "aa4cf90e-b9bd-40bc-93dd-ff7f08f8bd19"
    
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
    
    @IBAction func pressedRoseFireLogin(_ sender: Any) {
        Rosefire.sharedDelegate().uiDelegate = self
        Rosefire.sharedDelegate().signIn(registryToken: REGISTRY_TOKEN) { (err, result) in
          if let err = err {
            print("Rosefire sign in error! \(err)")
            return
          }
          
          Auth.auth().signIn(withCustomToken: result!.token) { (authResult, error) in
            if let error = error {
              print("Firebase sign in error! \(error)")
              return
            }
            self.performSegue(withIdentifier: self.showAppSegueID, sender: self)
          }
        }
    }
}
