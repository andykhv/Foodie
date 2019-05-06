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
    @IBOutlet weak var budgetSegementControl: UISegmentedControl!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
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
        restaurantQuery.distance = 12 // default distance is 12
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
            self.restaurantQuery.query = unwrappedSearchText
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
    // budgetSegCtrl value change
    @IBAction func budgetChanged(_ sender: Any) {
        switch budgetSegementControl.selectedSegmentIndex {
        case 1:
            self.restaurantQuery.budget = 2
        case 2:
            self.restaurantQuery.budget = 3
        case 3:
            self.restaurantQuery.budget = 4
        default:
            self.restaurantQuery.budget = 1
        }
        os_log("budget seg control changed", log: OSLog.default, type: .debug)
    }
    
    // distanceSlider value change
    @IBAction func distanceChanged(_ sender: UISlider) {
        self.restaurantQuery.distance = Int(distanceSlider.value)
        distanceLabel.text = String(self.restaurantQuery.distance)
        os_log("distance changed", log: OSLog.default, type: .debug)
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
