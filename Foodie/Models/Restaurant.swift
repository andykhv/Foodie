//
//  Restaurant.swift
//  Foodie
//
//  Created by Andy Khov on 4/29/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

// Decodable structs for JSON parsing Yelp Fusion Business Endpoint
struct Restaurants: Codable {
    let businesses: [Restaurant]
}

struct Restaurant: Codable {
    let id: String
    let name: String
    let image_url: String
    let url: String
    let phone: String
    let review_count: Int
    let rating: Float
    let coordinates: Coordinates
    let location: Location
    let price: String
    let is_closed: Bool
}

struct Location: Codable {
    let address1: String
    let address2: String!
    let city: String
    let zip_code: String
    let country: String
    let state: String
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}
