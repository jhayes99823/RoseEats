//
//  OrderTableViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/17/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class OrderTableViewController:UITableViewController{
    
    
    
    let OrderCellidentifier = "OrderCell"
    let detailSegueIdentifier = "DetailSegue"
    var orders: [OrderItem]?
    var User: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem       
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCellidentifier, for: indexPath)
        cell.textLabel?.text = orders![indexPath.row].MenuItem
        return cell
    }
    
  /*  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return Auth.auth().currentUser?.uid == User
       }*/
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print(indexPath.row)
            orders!.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
