//
//  MenuItemDetailViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var menuItem: MenuItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        testLabel.text = menuItem?.Name
        
    }
}
