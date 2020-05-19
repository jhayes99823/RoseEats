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

        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(MenuTableCell.self, forCellReuseIdentifier: menuPageTableCellID)

        titleLabel.text = strTitle
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
        }
    }
}
