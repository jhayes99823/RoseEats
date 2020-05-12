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
    
    var restaurantRef: CollectionReference!
    var restaurantListener: ListenerRegistration!
    
    var pageIndex: Int!
    var strTitle: String!
    
    var menuPageTableCellID = "MenuItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantRef = Firestore.firestore().collection("Restaurant")
        
        tableView.delegate = self
        tableView.dataSource = self
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           restaurantListener.remove()
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuPageTableCellID) as! MenuTableCell
        
        cell.menuItemLabel?.text = self.animals[indexPath.row]
        cell.menuItemImageView?.image = UIImage(named: "burger-plain.jpg")
                
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == menuDetailpageSegue {
            if tableView.indexPathForSelectedRow != nil {
                (segue.destination as! MenuItemDetailViewController).restaurant = restaurants[self.pageIndex]
            }
        }
    }
}
