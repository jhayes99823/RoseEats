//
//  SecondViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class PreviousOrderTableCell: UITableViewCell {
    
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var dateOrdered: UILabel!
}

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    var showPreviousOrderDetailSegue = "PreviousOrderDetailViewSegue"
    var previousOrderCellID = "PreviousOrderCell"
    
    var ordersRef: CollectionReference!
    var ordersListener: ListenerRegistration!
    
    var previousOrders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ordersRef = Firestore.firestore().collection("Orders")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        ordersListener = ordersRef.whereField("User", isEqualTo: Auth.auth().currentUser!.uid).order(by: "Date").addSnapshotListener { (querySnapShot, error) in
            self.previousOrders.removeAll()
            querySnapShot?.documents.forEach({ (docSnapShot) in
                self.previousOrders.append(Order(documentSnapShot: docSnapShot))
            })
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ordersListener.remove()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previousOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: previousOrderCellID) as! PreviousOrderTableCell
        
        print(previousOrders[indexPath.row])
        cell.restName.text = previousOrders[indexPath.row].Restaurant

        cell.dateOrdered.text = "May 12, 1921"
        
        cell.totalCost.text = "652.12"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == showPreviousOrderDetailSegue) {
            if let indexPath = tableView.indexPathForSelectedRow {
                           (segue.destination as! PreviousOrderDetailViewController).order = previousOrders[indexPath.row]
            }
        }
    }
}

