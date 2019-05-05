//
//  RestaurantQuery.swift
//  Foodie
//
//  Created by Andy Khov on 4/28/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

class RestaurantQuery {
    // MARK: properties
    var query: String
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var useCurrentLoc: Bool?
    var budget: Int
    var distance: Int
    
    // MARK: init
    init() {
        self.query = ""
        self.budget = 1
        self.distance = 1
    }
}
