//
//  RestaurantTableViewCell.swift
//  Foodie
//
//  Created by Andy Khov on 11/17/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    var restaurantUrl: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func openYelpUrl(_ sender: UIButton) {
        
        print("---------------yelp button pressed------------------")
        guard let url = URL(string: self.restaurantUrl) else {
            print("hellllooo")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
