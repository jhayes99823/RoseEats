//
//  ConfirmationPageViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/24/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class ConfirmationPageViewController: UIViewController {
    var reviewSegueID = "GoToReviewSegue"
    var homeSegueID = "GoHomeSegue"
    
    @IBAction func pressedBackToHomeButton(_ sender: Any) {
        performSegue(withIdentifier: homeSegueID, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == reviewSegueID {
            (segue.destination as! CustomTabBarController).order = Order()
        }
    }
}
