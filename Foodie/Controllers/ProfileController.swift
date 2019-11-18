//
//  ProfileController.swift
//  Foodie
//
//  Created by Andy Khov on 10/22/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import os.log
import Firebase

class ProfileController: UIViewController, UITableViewDataSource {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var restaurants: [Restaurant] = []
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initiallize self.restaurants
        self.tableView.dataSource = self
        
        if let user = Auth.auth().currentUser {
            self.emailLabel.text = user.email
            getUserRestaurants(withUserId: user.uid, completion: {(querySnapshot, err) in
                if let err = err {
                    os_log("%@", log: OSLog.default, type: .info, err.localizedDescription)
                } else {
                    for document in querySnapshot!.documents {
                        self.restaurants.append(self.convertDocumentToRestaurant(document.data()))
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            logout(exception: {
                os_log("unable to log out of Firebase Authentication", log: OSLog.default, type: .info)
            })
        }
    }
    
    // MARK: UITableViewDataSource protocol funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell") as! RestaurantTableViewCell
           
        cell.restaurantLabel.text = self.restaurants[indexPath.row].name
        cell.restaurantUrl = self.restaurants[indexPath.row].url
        cell.restaurantImageView.image = loadRemoteImage(with: self.restaurants[indexPath.row].image_url)
        cell.ratingImageView.image = getRatingUIImage(self.restaurants[indexPath.row].rating)
           
        return cell
    }
    
    // MARK: Private
    private func convertDocumentToRestaurant(_ document: [String : Any]) -> Restaurant {
        let restaurant = Restaurant(
            id: document["id"] as! String,
            name: document["name"] as! String,
            image_url: document["image_url"] as! String,
            url: document["url"] as! String,
            phone: document["phone"] as! String,
            review_count: document["review_count"] as! Int,
            rating: document["rating"] as! Float,
            coordinates: Coordinates(latitude: 0.0, longitude: 0.0),
            location: Location(address1: "", address2: "", city: "", zip_code: "", country: "", state: ""),
            price: document["price"] as! String,
            is_closed: false
        )
        
        return restaurant
    }
    
    private func loadRemoteImage(with url: String) -> UIImage? {
        let imageUrl = URL(string: url)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)
    }
    
    // return rating UIImage? based on float
    private func getRatingUIImage(_ rating: Float) -> UIImage? {
        switch rating {
        case 0...0.99:
            return UIImage(named: "rating0")
        case 1...1.49:
            return UIImage(named: "rating1")
        case 1.5...1.99:
            return UIImage(named: "rating1half")
        case 2...2.49:
            return UIImage(named: "rating2")
        case 2.5...2.99:
            return UIImage(named: "rating2half")
        case 3...3.49:
            return UIImage(named: "rating3")
        case 3.5...3.99:
            return UIImage(named: "rating3half")
        case 4...4.49:
            return UIImage(named: "rating4")
        case 4.5...4.99:
            return UIImage(named: "rating4half")
        default:
            return UIImage(named: "rating5")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
