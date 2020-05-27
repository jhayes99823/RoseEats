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
    
    var menuDetailpageSegue = "MenuDetailpageSegue"
    var addMoreToOrderSegue = "AddMoreToOrderSegue"
    var reviewOrderSegue = "ReviewOrderSegue"
        
    @IBAction func pressedAddToCart(_ sender: Any) {
        print("In the pressed function")
        
        if(orders == nil){
                       var orderItems = [OrderItem]()
            orderItems.append(OrderItem(MenuItem: menuItem!.id, Quantity: Int(quantityLabel.text!)!, Name: menuItem!.Name))
                       orders = Order(Restaurant: currentRest!, User: Auth.auth().currentUser!.uid, Items: orderItems)
                   }else{
            orders!.Items.append(OrderItem(MenuItem: menuItem!.id, Quantity: Int(quantityLabel.text!)!, Name: menuItem!.Name))
                   }
        
        let nextActionALert = UIAlertController(title: "Item(s) was added to your order!", message: "Where to next?", preferredStyle: .alert)
        
        nextActionALert.addAction(UIAlertAction(title: "Return To Menu", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: self.menuDetailpageSegue, sender: self)
        }))
        
        nextActionALert.addAction(UIAlertAction(title: "Review Order", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: self.reviewOrderSegue, sender: self)
        }))
        
        nextActionALert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(nextActionALert, animated: true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addToCartButton.backgroundColor = .clear
        addToCartButton.layer.cornerRadius = 3
        addToCartButton.layer.borderWidth = 1
        addToCartButton.layer.borderColor = UIColor.black.cgColor
        quantityStepper.autorepeat = true
        quantityStepper.minimumValue = 1
        if let imgString = self.menuItem!.ImageName {
                    if let imgUrl = URL(string: imgString) {
                      DispatchQueue.global().async { // Download in the background
                        do {
                          let data = try Data(contentsOf: imgUrl)
                          DispatchQueue.main.async { // Then update on main thread
                            self.imageView.image = UIImage(data: data)
                          }
                        } catch {
                          print("Error downloading image: \(error)")
                        }
                      }
                    }
        
                  }
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        pageTitle.text = menuItem?.Name
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
            (segue.destination as! CustomTabBarController).order = orders!
        } else if (segue.identifier == reviewOrderSegue) {
            (segue.destination as! OrderTableViewController).orders = orders!.Items
            (segue.destination as! OrderTableViewController).rest = orders!.Restaurant
            (segue.destination as! OrderTableViewController).User = orders!.User

        }
    }
    
}
