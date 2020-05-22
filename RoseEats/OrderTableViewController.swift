//
//  OrderTableViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/17/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class OrderTableCell: UITableViewCell {
    
    @IBOutlet weak var NameCell: UILabel!
    @IBOutlet weak var AmountCell: UILabel!
    
    var table:OrderTableViewController?
    
    @IBAction func OnEditButtonPressed(_ sender: Any) {
        table!.Getpopup(text: NameCell.text!, amt: AmountCell.text!)
    }
    
}


class OrderTableViewController:UITableViewController{
    
    
    let OrderCellidentifier = "OrderCell"
    let mainPageSegue = "MainPageSegue"
    var orders: [OrderItem]?
    var rest:String?
    var User:String?
    
    @IBOutlet var BlurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!

    @IBOutlet weak var popupItemName: UILabel!
    @IBOutlet weak var QuantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBAction func StepperValueChanged(_ sender: Any) {
        quantityLabel.text = Int((sender as! UIStepper).value).description
        print((sender as! UIStepper).value)
    }
    
    @IBAction func pressedDone(_ sender: Any) {
        RemovePopup()
    }
    public func Getpopup(text:String, amt: String){
        quantityLabel.text = amt
        popupItemName.text = text
        QuantityStepper.value = Double(amt)!
        animateIn(neededView: BlurView)
        animateIn(neededView: popUpView)
    }
    
    public func RemovePopup(){
        editamt(of: popupItemName.text!, to: quantityLabel.text!)
        animateOut(neededView: BlurView)
        animateOut(neededView: popUpView)
        self.tableView.reloadData()
    }
    
    func editamt(of name:String, to amt:String){
        for item in orders!{
            if(item.MenuItem == name){
                item.Quantity = Int(amt)!
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        QuantityStepper.autorepeat = true
        QuantityStepper.minimumValue = 1
        self.tableView.rowHeight = 55
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BlurView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width*1.2, height: self.view.bounds.height*1.2)
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.7, height: self.view.bounds.height * 0.3)
        popUpView.layer.cornerRadius = 20
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector((backButtonPressed)))
    }
    
    func animateIn(neededView: UIView){
        let background = self.view!
        background.addSubview(neededView)
        neededView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        neededView.alpha = 0
        neededView.center = background.center
        
        UIView.animate(withDuration: 0.3) {
            neededView.transform = CGAffineTransform(scaleX: 1, y: 1)
            neededView.alpha = 1
        }
    }
    
    func animateOut(neededView: UIView){
        UIView.animate(withDuration: 0.3, animations:  {
            neededView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            neededView.alpha = 0
        }, completion: {_ in
            neededView.removeFromSuperview()
        })
    }
    
    @objc func backButtonPressed(){
        self.performSegue(withIdentifier: mainPageSegue, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCellidentifier, for: indexPath) as! OrderTableCell
        
        cell.contentView.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: cell.contentView.frame.height * 0.8)
        
        cell.NameCell.text = orders![indexPath.row].MenuItem
        cell.AmountCell.text = String(orders![indexPath.row].Quantity)
        cell.table = self
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.masksToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print(indexPath.row)
            orders!.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mainPageSegue {
            (segue.destination as! CustomTabBarController).order = Order(Restaurant: rest!, User: User!, Items: orders!)
        }
    }
}

/*extension OrderTableViewController: OrderCellDelegate{
    func didPressEdit(){
        
    }
}*/
