//
//  Order.swift
//  RoseEats
//
//  Created by CSSE Department on 5/13/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import Foundation
import Firebase

class OrderItem {
    var MenuItem: String
    var Quantity: Int
    var Name: String
    
    init(MenuItem: String, Quantity: Int, Name: String) {
        self.MenuItem = MenuItem
        self.Quantity = Quantity
        self.Name = Name
    }
    
    init(dictionary: [String : Any]) {
        self.MenuItem = dictionary["MenuItem"] as! String
        self.Quantity = dictionary["Quantity"] as! Int
        self.Name = ""
    }
}

class Order {
    var Items: [OrderItem]
    var User: String
    var Restaurant: String
    var id: String
    
    init(){
        self.Restaurant = ""
        self.User = ""
        self.Items = [OrderItem]()
        self.id = ""
    }
    
    init(Restaurant: String, User: String, Items: [OrderItem]) {
        self.Restaurant = Restaurant
        self.User = User
        self.Items = Items
        self.id = ""
    }
    
    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.Items = [OrderItem]()
        
        let temp = data["Items"] as! NSArray
        
        for ele in temp {
            var convert = ele as! NSDictionary
            Items.append(OrderItem(dictionary: convert as! [String : Any]))
        }
        
        self.User = data["User"] as! String
        self.Restaurant = data["Restaurant"] as! String
    }
}
