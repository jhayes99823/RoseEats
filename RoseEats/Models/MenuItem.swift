//
//  MenuItem.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import Foundation
import Firebase

class MenuItem {
    var id: String!
    var Name: String!
    var Price: Float!
    var WhereServed: [String]!
    var ImageName: String!
    
    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.Name = (data["Name"] as! String)
        self.Price = data["Location"] as? Float
        self.WhereServed = data["WhereServed"] as? [String]
        self.ImageName = data["ImageName"] as? String
    }
}
