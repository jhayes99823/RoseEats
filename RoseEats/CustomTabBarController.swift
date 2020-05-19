//
//  CustomTabBarController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/19/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import  FirebaseAuth
class CustomTabBarController: UITabBarController{    
    let TabBarToMenuPageSegue = "TabBarToMenuPage"
    let checkCartSegue = "CheckCartSegue"

    var order:Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: self, action: #selector(showMenu))
    }
    
    @objc func showMenu(){
        let alertController = UIAlertController(title: "Menu Options", message: "", preferredStyle: .actionSheet)
                
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .default) { (action) in
            do{
                try Auth.auth().signOut()
            }catch{
                print("SignOut Error")
            }
        })
        
        alertController.addAction(UIAlertAction(title: "My Account", style: .default) { (action) in
            //self.isShowAllMode = !self.isShowAllMode
            print("Show My Account")
            //self.startListening()
        })
             
        
        alertController.addAction(UIAlertAction(title: "Check Cart", style: .default) { (action) in
            //self.isShowAllMode = !self.isShowAllMode
            print("Check Cart")
            if(self.order == nil){
                print("EMPTY ORDER")
            }else{
                self.performSegue(withIdentifier: self.checkCartSegue, sender: self)
            }
            
            //self.startListening()
        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TabBarToMenuPageSegue {
            (segue.destination as! MenusPageViewController).order = order
        }else if segue.identifier == checkCartSegue{
            (segue.destination as! OrderTableViewController).orders = order!.Items
        }
    }
}
