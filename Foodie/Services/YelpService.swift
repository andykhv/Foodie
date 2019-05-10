//
//  YelpService.swift
//  Foodie
//
//  Created by Andy Khov on 5/9/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import Foundation
import Alamofire

func searchRestaurants(with query: RestaurantQuery) -> Void {
    let params = buildParams(with: query)
    Alamofire.request("https://api.yelp.com/v3/businesses/search")
}

private func buildParams(with query: RestaurantQuery) -> Parameters {
    var params = Parameters()
    params["term"] = query.term
    params["radius"] = query.radius
    params["price"] = String(query.price)
    params["categories"] = "food"
    
    if (query.useCurrentLoc) {
        params["latitude"] = query.latitude
        params["longitude"] = query.longitude
    } else {
        params["location"] = query.location
    }
    
    return params
}
