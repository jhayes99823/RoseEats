//
//  PageContentViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
}

class MenuPageContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    var pageIndex: Int = 0
    var strTitle: String!
    
    var menuPageTableCellID = "MenuItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(MenuTableCell.self, forCellReuseIdentifier: menuPageTableCellID)
        tableView.delegate = self
        tableView.dataSource = self
        titleLabel.text = strTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuPageTableCellID) as! MenuTableCell
        
        
        cell.menuItemLabel?.text = self.animals[indexPath.row]
//        cell.menuItemImageView?.image = UIImage(named: "burger-plain")
                
        return cell
    }
    
}
