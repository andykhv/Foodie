//
//  RestaurantController.swift
//  Foodie
//
//  Created by Andy Khov on 5/24/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import os.log

/* TODO:
 * Update ImageView
 * Update Call
 * Update Directions
 * Update yelp image to website
 */

class RestaurantController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    var restaurant: Restaurant!
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.restaurant.name
        self.availabilityLabel.text = self.restaurant.is_closed ? "Closed" : "Open"
        self.addressLabel.text = self.restaurant.location.address1
        self.cityStateZipLabel.text = "\(self.restaurant.location.city), \(self.restaurant.location.state) \(self.restaurant.location.zip_code)"
        self.reviewsLabel.text = String(self.restaurant.review_count)
        self.ratingImage.image = getRatingUIImage(self.restaurant.rating)
        self.restaurantImage.image = loadRemoteImage(with: self.restaurant.image_url)
    }
    
    // MARK: private
    
    // return remote UIImage? (TODO: make asynchronous)
    private func loadRemoteImage(with url: String) -> UIImage? {
        let imageUrl = URL(string: url)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)
    }
    
    // return rating UIImage? based on float
    private func getRatingUIImage(_ rating: Float) -> UIImage? {
        switch rating {
        case 0...1:
            return UIImage(named: "rating0")
        case 1...1.49:
            return UIImage(named: "rating1")
        case 1.5...2:
            return UIImage(named: "rating1half")
        case 2...2.49:
            return UIImage(named: "rating2")
        case 2.5...3:
            return UIImage(named: "rating2half")
        case 3...3.49:
            return UIImage(named: "rating3")
        case 3.5...4:
            return UIImage(named: "rating3half")
        case 4...4.49:
            return UIImage(named: "rating4")
        case 4.5...5:
            return UIImage(named: "rating4half")
        default:
            return UIImage(named: "rating5")
        }
    }
}
