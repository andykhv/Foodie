//
//  YelpService.swift
//  Foodie
//
//  Created by Andy Khov on 5/9/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import Foundation
import Alamofire
import os.log

let BUSINESS_SEARCH_ENDPOINT = "https://api.yelp.com/v3/businesses/search"
let milesToMetersRatio = 1609

func searchRestaurants(with query: RestaurantQuery, completion completionHander: @escaping (DataResponse<Any>) -> Void) -> Void {
//    guard let API_KEY = getApiKey() else {
//        os_log("Yelp API Key not found", log: OSLog.default, type: .error)
//        return
//    }
    let API_KEY = "teKfUA1ujucw1OT2Lowby9L8VEARvrm0kTgc84RJomxL5zAKdTWJu2_-szByB3hSPJLywEtawpDsmtk4pPt1naNmzVLbxmq46rdoY-BvASgVuA-bNpXrHFrwtk_HXHYx"
    let params = buildParams(with: query)
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(API_KEY)"
    ]
    os_log("starting GET yelp/v3/businesses/search", log: OSLog.default, type: .error)
    Alamofire.request(BUSINESS_SEARCH_ENDPOINT, parameters: params, headers: headers).responseJSON(completionHandler: completionHander)
}

private func buildParams(with query: RestaurantQuery) -> Parameters {
    var params = Parameters()
    params["term"] = query.term
    params["radius"] = query.radius * milesToMetersRatio
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

private func getApiKey() -> String? {
    if  let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
        let xml = FileManager.default.contents(atPath: path) {
        let keys = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String]
        guard let key = keys?[0] else {
            return nil
        }
        return key
    }
    
    return nil
}
