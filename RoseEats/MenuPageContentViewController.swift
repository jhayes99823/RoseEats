//
//  PageContentViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MenuPageContentViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    var pageIndex: Int = 0
    var strTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = strTitle
    }

}
