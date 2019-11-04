//
//  ShakeController.swift
//  Foodie
//
//  Created by Andy Khov on 5/5/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import AudioToolbox
import os.log
import Alamofire

class ShakeController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    var loadingImage: UIImage!
    var restaurantQuery: RestaurantQuery!
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // load "loading" icon
        loadingImage = UIImage.animatedImageNamed("loading", duration: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // set ui
        self.infoLabel.text = "Shake your phone to get a restaurant!"
        self.infoLabel.textColor = .black
        self.imageView.image = UIImage(named: "PhoneShake")
    }
    
    // MARK: UIResponder
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // start vibration
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // set label to "Finding a Restaurant..."
            infoLabel.text = "Finding a Restaurant..."
            
            // change image to animated loading icon
            imageView.image = loadingImage
            os_log("shaking detected", log: OSLog.default, type: .debug)
            
            // call YelpService.loadRestaurants
            os_log("calling searchRestaurants", log: OSLog.default, type: .debug)
            searchRestaurants(with: self.restaurantQuery, completion: loadRestaurantJson)
        }
    }
    
    // MARK: private
    // closure for YelpService's searchRestaurants()
    private func loadRestaurantJson(_ response: DataResponse<Any>) -> Void {
        os_log("received response", log: OSLog.default, type: .debug)
        if let data = response.data {
            // decode json to Restaurant struct
            do {
                let restaurants = try JSONDecoder().decode(Restaurants.self, from: data)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let restaurantController = storyBoard.instantiateViewController(withIdentifier: "restaurantController") as! RestaurantController
                if (restaurants.businesses.count > 0) {
                    restaurantController.restaurant = pickRestaurant(self.restaurantQuery, restaurants)
                    self.navigationController?.show(restaurantController, sender: self)
                } else {
                    self.infoLabel.text = "Cannot find a restaurant"
                    self.infoLabel.textColor = .red
                }
            } catch {
                self.infoLabel.text = "Cannot find a restaurant"
                self.infoLabel.textColor = .red
            }
        }
    }
    
    // pick a restaurant randomly and based on user-chosen rating
    private func pickRestaurant(_ restaurantQuery: RestaurantQuery, _ restaurants: Restaurants) -> Restaurant {
        var pickedRestaurant = restaurants.businesses[Int.random(in: 0..<restaurants.businesses.count)]
        print(restaurantQuery.rating)
        print(pickedRestaurant.rating)
        while (restaurantQuery.rating > pickedRestaurant.rating) {
            pickedRestaurant = restaurants.businesses[Int.random(in: 0..<restaurants.businesses.count)]
        }
        
        return pickedRestaurant
    }
}
