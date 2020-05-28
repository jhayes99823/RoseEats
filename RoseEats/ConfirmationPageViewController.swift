//
//  ConfirmationPageViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/24/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class ConfirmationPageViewController: UIViewController {
    var reviewSegueID = "GoToReviewSegue"
    var homeSegueID = "GoHomeSegue"

    var pickUpRest: String!
    
    @IBOutlet weak var extraInfoLabell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       extraInfoLabell.text! = "Head to \(pickUpRest!) in 15 minutes to pick up your order. \nEnjoy your meal!"
    }
    
    @IBAction func pressedBackToHomeButton(_ sender: Any) {
        performSegue(withIdentifier: homeSegueID, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == homeSegueID {
            (segue.destination as! CustomTabBarController).order = Order()
        }
    }
}
