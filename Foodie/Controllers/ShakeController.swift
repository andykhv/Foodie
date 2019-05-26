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
        imageView.image = UIImage(named: "PhoneShake")
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
            let restaurants = try! JSONDecoder().decode(Restaurants.self, from: data)
            
            // present RestaurantController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let restaurantController = storyBoard.instantiateViewController(withIdentifier: "restaurantController") as! RestaurantController
            restaurantController.restaurant = restaurants.businesses[Int.random(in: 0..<restaurants.businesses.count)]
            self.present(restaurantController, animated: true, completion: nil)
        }
    }
}
