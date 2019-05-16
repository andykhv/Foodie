//
//  QueryController.swift
//  Foodie
//
//  Created by Andy Khov on 4/23/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import UIKit
import CoreLocation
import os.log

class QueryController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var locSearchBar: UISearchBar!
    @IBOutlet weak var priceSegmentControl: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var radiusLabel: UILabel!
    var locationManager: CLLocationManager!
    var restaurantQuery: RestaurantQuery!
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        foodSearchBar.delegate = self
        locSearchBar.delegate = self
        restaurantQuery = RestaurantQuery()
        
        // set location search icon to "LocationIcon"
        let locationIcon: UIImage? = UIImage(named: "LocationIcon")
        locSearchBar.setImage(locationIcon, for: .search, state: .normal)
        // set food search icon to "SearchIcon"
        let searchIcon: UIImage? = UIImage(named: "SearchIcon")
        foodSearchBar.setImage(searchIcon, for: .search, state: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantQuery.radius = 12 // default radius is 12
        determineCurrentLoc()
    }
    
    // MARK: UISearchBarDelegate funcs
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        os_log("searchBar's search button clicked", log: OSLog.default, type: .debug)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let unwrappedSearchText = searchBar.text else {
            os_log("searchBar contains empty text", log: OSLog.default, type: .debug)
            return
        }
        if (searchBar == foodSearchBar) {
            self.restaurantQuery.term = unwrappedSearchText
            os_log("foodSearchBar edited", log: OSLog.default, type: .debug)
        } else if (searchBar == locSearchBar) {
            searchBar.text = "Current Location"
            os_log("locSearchBar edited", log: OSLog.default, type: .debug)
        }
    }
    
    // MARK: CLLocationManagerDelegate funcs
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        manager.stopUpdatingLocation()
        self.restaurantQuery.latitude = userLocation.coordinate.latitude
        self.restaurantQuery.longitude = userLocation.coordinate.longitude
        self.restaurantQuery.useCurrentLoc = true
        os_log("current location updated", log: OSLog.default, type: .debug)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        os_log("current location error", log: OSLog.default, type: .debug)
    }
    
    // MARK: Actions
    // priceSegCtrl value change
    @IBAction func priceChanged(_ sender: Any) {
        switch priceSegmentControl.selectedSegmentIndex {
        case 1:
            self.restaurantQuery.price = 2
        case 2:
            self.restaurantQuery.price = 3
        case 3:
            self.restaurantQuery.price = 4
        default:
            self.restaurantQuery.price = 1
        }
        os_log("price seg control changed", log: OSLog.default, type: .debug)
    }
    
    // radiusSlider value change
    @IBAction func radiusChanged(_ sender: UISlider) {
        self.restaurantQuery.radius = Int(radiusSlider.value)
        radiusLabel.text = String(self.restaurantQuery.radius)
        os_log("radius changed", log: OSLog.default, type: .debug)
    }
    
    // MARK: Private
    private func determineCurrentLoc() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}
