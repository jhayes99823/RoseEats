//
//  CustomTabBarController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/19/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import  FirebaseAuth
class CustomTabBarController: UITabBarController,UITabBarControllerDelegate{
    let checkCartSegue = "CheckCartSegue"
    let SignOutSegue = "signOutSegue"
    var order:Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: self, action: #selector(showMenu))
        guard let viewcontrollers = viewControllers else{
            return
        }
        
        for viewcontroller in viewControllers!{
            if let pagecont = viewcontroller as? MenusPageViewController{
                pagecont.order = order
            }
        }

    }
    
    @objc func showMenu(){
        let alertController = UIAlertController(title: "Menu Options", message: "", preferredStyle: .actionSheet)
                
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .default) { (action) in
            do{
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: self.SignOutSegue, sender: self)
            }catch{
                print("SignOut Error")
            }
        })
        
        alertController.addAction(UIAlertAction(title: "My Account", style: .default) { (action) in
            print("Show My Account")
        })
             
        
        alertController.addAction(UIAlertAction(title: "Check Cart", style: .default) { (action) in
            if(self.order == nil){
                self.order = Order()
            }
            self.performSegue(withIdentifier: self.checkCartSegue, sender: self)
            
        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == checkCartSegue{
            (segue.destination as! OrderTableViewController).orders = order!.Items
            (segue.destination as! OrderTableViewController).rest = order!.Restaurant
            (segue.destination as! OrderTableViewController).User = order!.User
        }
    }
}
