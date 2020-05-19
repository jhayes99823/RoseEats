//
//  PageContentViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class MenuTableCell: UITableViewCell {
    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
}

class MenuPageContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var menuDetailpageSegue = "ShowMenuItemDetailView"
    var checkCartSegue = "CheckCartSegue"

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    var restaurants = [Restaurant]()
    var menuItems = [MenuItem]()
    var order: Order?
    
    var restaurantRef: CollectionReference!
    var restaurantListener: ListenerRegistration!
    
    var menuItemRef: CollectionReference!
    var menuItemListener: ListenerRegistration!
    
    var pageIndex: Int!
    var strTitle: String!
    
    var menuPageTableCellID = "MenuItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        restaurantRef = Firestore.firestore().collection("Restaurant")
        menuItemRef = Firestore.firestore().collection("MenuItem")
        
        navigationItem.backBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: self, action: #selector(showMenu))
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(MenuTableCell.self, forCellReuseIdentifier: menuPageTableCellID)

        titleLabel.text = strTitle
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantListener = restaurantRef.order(by: "Name").addSnapshotListener {
                   (querySnapShot, error) in if let querySnapShot = querySnapShot {
                       self.restaurants.removeAll()
                       querySnapShot.documents.forEach { (docSnapShot) in
                           self.restaurants.append(Restaurant(documentSnapShot: docSnapShot))
                       }
                       self.tableView.reloadData()
                   }
                   else {
                       print("Error getting movie quotes \(error!)")
                       return
                   }
               }
        menuItemRef.whereField("WhereServed", arrayContains: self.strTitle!).getDocuments { (querySnapShot, error) in
            self.menuItems.removeAll()
            querySnapShot?.documents.forEach({ (docSnapShot) in
                self.menuItems.append(MenuItem(documentSnapShot: docSnapShot))
            }
            )
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           restaurantListener.remove()
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuPageTableCellID) as! MenuTableCell
        
        cell.menuItemLabel?.text = self.menuItems[indexPath.row].Name
        cell.menuItemImageView?.image = UIImage(named: self.menuItems[indexPath.row].ImageName)
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.masksToBounds = true
                
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == menuDetailpageSegue {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! MenuItemDetailViewController).menuItem = menuItems[indexPath.row]
                (segue.destination as! MenuItemDetailViewController).orders = order
                (segue.destination as! MenuItemDetailViewController).currentRest = strTitle
            }
        }else if segue.identifier == checkCartSegue{
            (segue.destination as! OrderTableViewController).orders = order!.Items
        }
    }
}
