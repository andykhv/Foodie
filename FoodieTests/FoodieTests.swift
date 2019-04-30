//
//  FoodieTests.swift
//  FoodieTests
//
//  Created by Andy Khov on 4/14/19.
//  Copyright © 2019 Andy Khov. All rights reserved.
//

import XCTest
@testable import Foodie

class FoodieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJsonToRestaurant() {
        let data = """
        {
          "id": "WavvLdfdP6g8aZTtbBQHTw",
          "alias": "gary-danko-san-francisco",
          "name": "Gary Danko",
          "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
          "is_claimed": true,
          "is_closed": false,
          "url": "https://www.yelp.com/biz/",
          "phone": "+14157492060",
          "review_count": 5296,
          "rating": 4.5,
          "location": {
            "address1": "800 N Point St",
            "address2": "",
            "address3": "",
            "city": "San Francisco",
            "zip_code": "94109",
            "country": "US",
            "state": "CA",
            "display_address": [
              "800 N Point St",
              "San Francisco, CA 94109"
            ],
            "cross_streets": ""
          },
          "coordinates": {
            "latitude": 37.80587,
            "longitude": -122.42058
          },
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
            "https://s3-media4.fl.yelpcdn.com/bphoto/FmXn6cYO1Mm03UNO5cbOqw/o.jpg",
            "https://s3-media4.fl.yelpcdn.com/bphoto/HZVDyYaghwPl2kVbvHuHjA/o.jpg"
          ],
          "price": "$$$$",
          "hours": [
            {
              "open": [
                {
                  "is_overnight": false,
                  "start": "1730",
                  "end": "2200",
                  "day": 0
                },
                {
                  "is_overnight": false,
                  "start": "1730",
                  "end": "2200",
                  "day": 1
                },
                {
                  "is_overnight": false,
                  "start": "1730",
                  "end": "2200",
                  "day": 2
                },
              ],
              "hours_type": "REGULAR",
              "is_open_now": false
            }
          ],
        }
        """.data(using: .utf8)
        if let unwrappedData = data {
            do {
                let myStruct = try JSONDecoder().decode(Restaurant.self, from: unwrappedData)
                print(myStruct)
            } catch {
                print("error")
            }
        }
    }
    
}
