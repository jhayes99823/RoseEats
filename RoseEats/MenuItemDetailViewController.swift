//
//  MenuItemDetailViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

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
    
    var menuDetailpageSegue = "MenuDetailpageSegue"
    var addMoreToOrderSegue = "AddMoreToOrderSegue"
    var reviewOrderSegue = "ReviewOrderSegue"
    
    @IBAction func pressedAddToCart(_ sender: Any) {
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

    
    func existsinOrder(MenutemName: String) -> Int{
        var i = 0
        for item in orders!.Items{
            if(item.MenuItem == MenutemName){
                return i
            }
            i+=1
        }
        return -1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == menuDetailpageSegue {
            if(orders == nil){
                var orderItems = [OrderItem]()
                orderItems.append(OrderItem(MenuItem: menuItem!.Name, Quantity: Int(quantityLabel.text!)!))
                orders = Order(Restaurant: currentRest!, User: Auth.auth().currentUser!.uid, Items: orderItems)
            }else{
                let i = existsinOrder(MenutemName: menuItem!.Name)
                if(i != -1){
                    orders!.Items[i].Quantity = Int(quantityLabel.text!)!
                }else{
                    orders!.Items.append(OrderItem(MenuItem: menuItem!.Name, Quantity: Int(quantityLabel.text!)!))
                }
            }
            (segue.destination as! CustomTabBarController).order = orders!
            //(segue.destination as! MenuPageContentViewController).strTitle = currentRest!
        } else if (segue.identifier == reviewOrderSegue) {
            (segue.destination as! OrderTableViewController).orders = orders!.Items
            (segue.destination as! OrderTableViewController).rest = orders!.Restaurant
            (segue.destination as! OrderTableViewController).User = orders!.User

        }
    }
    
}
