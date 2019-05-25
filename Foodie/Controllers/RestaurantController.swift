//
//  RestaurantController.swift
//  Foodie
//
//  Created by Andy Khov on 5/24/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import os.log

class RestaurantController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
