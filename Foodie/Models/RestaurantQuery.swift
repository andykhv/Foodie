//
//  RestaurantQuery.swift
//  Foodie
//
//  Created by Andy Khov on 4/28/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

class RestaurantQuery {
    // MARK: properties
    var term: String
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var useCurrentLoc: Bool
    var price: Int
    var radius: Int
    
    // MARK: init
    init() {
        self.term = ""
        self.price = 1
        self.radius = 1
        self.useCurrentLoc = false
    }
}
