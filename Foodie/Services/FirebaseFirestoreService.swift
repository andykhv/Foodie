//
//  FirebaseDatabaseService.swift
//  Foodie
//
//  Created by Andy Khov on 11/10/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import Foundation
import Firebase

let userCollection = "users"
let restaurantCollection = "restaurants"

func getUserRestaurants(withUserId id: String, completion completionHandler: @escaping FIRQuerySnapshotBlock) -> Void {
    let db = Firestore.firestore()
    db.collection(userCollection).document(id).collection(restaurantCollection).getDocuments(completion: completionHandler)
}

func addUserRestaurant(withUserId id: String, restaurant: Restaurant) -> Void {
    let db = Firestore.firestore()
    let restaurantDoc = convertToValidFirestoreDoc(restaurant: restaurant)
    
    db.collection(userCollection).document(id).collection(restaurantCollection).addDocument(data: restaurantDoc)
}

private func convertToValidFirestoreDoc(restaurant: Restaurant) -> [String: Any] {
    let restaurantDoc: [String: Any] = [
        "address1": restaurant.location.address1,
        "address2": restaurant.location.address2 ?? "",
        "city": restaurant.location.city,
        "state": restaurant.location.state,
        "country": restaurant.location.country,
        "zip_code": restaurant.location.zip_code,
        "id": restaurant.id,
        "image_url": restaurant.image_url,
        "name": restaurant.name,
        "phone": restaurant.phone,
        "price": restaurant.price,
        "rating": restaurant.rating,
        "review_count": restaurant.review_count,
        "url": restaurant.url,
        "coordinates": GeoPoint(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
    ]
    
    return restaurantDoc
}
