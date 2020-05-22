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
    
    init(MenuItem: String, Quantity: Int) {
        self.MenuItem = MenuItem
        self.Quantity = Quantity
    }
}

class Order {
    var Items: [ OrderItem]
    var User: String
    var Restaurant: String
    var id: String
<<<<<<< HEAD
=======
    
    init(){
        self.Restaurant = ""
        self.User = ""
        self.Items = [OrderItem]()
        self.id = ""
    }
>>>>>>> back-to-start
    
    init(Restaurant: String, User: String, Items: [OrderItem]) {
        self.Restaurant = Restaurant
        self.User = User
        self.Items = Items
        self.id = ""
    }
    
    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.Items = data["Items"] as! [OrderItem]
        self.User = data["User"] as! String
        self.Restaurant = data["Restaurant"] as! String
    }
}
