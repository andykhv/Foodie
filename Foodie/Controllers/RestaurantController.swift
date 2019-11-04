//
//  RestaurantController.swift
//  Foodie
//
//  Created by Andy Khov on 5/24/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import MapKit
import os.log

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
    
    // MARK: Actions
    
    // called when user presses "Dislike" button
    @IBAction func userDislikes(_ sender: Any) {
        // pop self from navigation stack
        self.navigationController?.popViewController(animated: true)
    }
    
    // called when user presses "Like" button
    @IBAction func showActionSheet(_ sender: Any) {
        let menu = UIAlertController(title: nil, message: "Get Restaurant Information", preferredStyle: .actionSheet)
        let phoneAction = UIAlertAction(title: "Call the Restaurant", style: .default, handler: self.callRestaurant)
        let mapsAction = UIAlertAction(title: "Get Directions", style: .default, handler: self.openMapsApp)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        menu.addAction(phoneAction)
        menu.addAction(mapsAction)
        menu.addAction(cancelAction)
        
        self.present(menu, animated: true, completion: nil)
    }
    
    // called when user presses "Yelp" button
    @IBAction func openUrl(_ sender: Any) {
        guard let url = URL(string: self.restaurant.url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    // MARK: private
    
    // handler for phoneAction UIAlertAction
    private func callRestaurant(_ alertAction: UIAlertAction) -> Void {
        os_log("calling restaurant", log: OSLog.default, type: .debug)
        if let url = URL(string: "tel://\(self.restaurant.phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    // handler for mapsAction UIAlertAction
    private func openMapsApp(_ alertAction: UIAlertAction) -> Void {
        os_log("opening Maps app with restaurant coordinates", log: OSLog.default, type: .debug)
        
        let latitude: CLLocationDegrees = self.restaurant.coordinates.latitude
        let longitude: CLLocationDegrees = self.restaurant.coordinates.longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.restaurant.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    // return remote UIImage? (TODO: make asynchronous)
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
}
