//
//  Restaurant.swift
//  RoseEats
//
//  Created by CSSE Department on 5/12/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import Foundation
import Firebase

class Restaurant {
    var name: String!
    var location: String!
    var id: String!

    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.name = data["Name"] as! String
        self.location = data["Location"] as! String
    }
}
