//
//  PreviewOrderDetailViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/20/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class IndephPreviousOrderTableCell: UITableViewCell {
    
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
}

class PreviousOrderDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cellID = "PreviosuCellDetailView"
    
    var order: Order!
    
    var menuItemRefOther: CollectionReference!
    
    var MenuItemsForOrder = [MenuItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItemRefOther = Firestore.firestore().collection("MenuItem")
        
        pageTitle.text = order.Restaurant + "Date of order will go here"
        pageDescription.text = "$totalcost goes here"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("gettig my menu ietems from firebase rn")
        getMenItemsForPage()
        print("whats in hrhere rn \(self.MenuItemsForOrder)")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("how many cells we lookin at \(order.Items.count)")
        return order.Items.count
    }
    
    
    func getMenItemsForPage() {
//        for item in self.order.Items {
//            print("whats it trying to get rn \(item.MenuItem)")
            menuItemRefOther.document("ZVubRRe2Rdz4o6HK80V7").getDocument{ (docsnap, error) in
                if let docsnap = docsnap {
                    print("who am i rn \(docsnap.documentID)")
                    self.MenuItemsForOrder.append(MenuItem(documentSnapShot: docsnap))
                }
                else {
                    print("something wnet wrong \(error)")
                    return
                }
            }
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! IndephPreviousOrderTableCell
        print("gsetting up the table rn")
        cell.nameLabel?.text = self.MenuItemsForOrder[indexPath.row].Name
        cell.foodImg?.image = UIImage(named: self.MenuItemsForOrder[indexPath.row].ImageName)
        cell.quantityLabel.text = self.order.Items[indexPath.row].Quantity.description
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.masksToBounds = true
                
        return cell
    }

}
