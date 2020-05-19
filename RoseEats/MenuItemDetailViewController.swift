//
//  MenuItemDetailViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import FirebaseAuth
class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBAction func quantityStepperPressed(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
    
    @IBOutlet weak var addToCartButton: UIButton!
    var menuItem: MenuItem?
    var orders: Order?
    var currentRest: String?
    var menuDetailpageSegue = "FigmamenuDetailpageSegue"
    @IBAction func pressedAddToCart(_ sender: Any) {
        print("In the pressed function")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addToCartButton.backgroundColor = .clear
        addToCartButton.layer.cornerRadius = 3
        addToCartButton.layer.borderWidth = 1
        addToCartButton.layer.borderColor = UIColor.black.cgColor
        quantityStepper.autorepeat = true
        quantityStepper.minimumValue = 1
        updateView()
    }
    
    func updateView() {
        pageTitle.text = menuItem?.Name
        imageView.image = UIImage(named: menuItem!.ImageName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == menuDetailpageSegue {
            if(orders == nil){
                var orderItems = [OrderItem]()
                orderItems.append(OrderItem(MenuItem: menuItem!.Name, Quantity: Int(quantityLabel.text!)!))
                orders = Order(Restaurant: currentRest!, User: Auth.auth().currentUser!.uid, Items: orderItems)
            }else{
                orders!.Items.append(OrderItem(MenuItem: menuItem!.Name, Quantity: Int(quantityLabel.text!)!))
            }
            
            (segue.destination as! MenuPageContentViewController).order = orders!
            (segue.destination as! MenuPageContentViewController).strTitle = currentRest!
        }
    }
    
}
