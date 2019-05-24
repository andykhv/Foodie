//
//  Restaurant.swift
//  Foodie
//
//  Created by Andy Khov on 4/29/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

// Decodable structs for JSON parsing Yelp Fusion Business Endpoint
struct Restaurants: Decodable {
    let restaurants: [Restaurant]
    let total: Int
}

struct Restaurant: Decodable {
    let id: String
    let name: String
    let image_url: String
    let url: String
    let phone: String
    let review_count: Int
    let rating: Float
    let location: Location
    let price: String
    let photos: [String]
    let hours: [Hours]
}

struct Location: Decodable {
    let address1: String
    let address2: String
    let city: String
    let zip_code: String
    let country: String
    let state: String
}

struct Hours: Decodable {
    let open: [Hour]
    let is_open_now: Bool
}

struct Hour: Decodable {
    let start: String
    let end: String
    let day: Int
}
