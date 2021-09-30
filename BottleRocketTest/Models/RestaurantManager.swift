//
//  RestaurantManager.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit

protocol RestaurantManagerDelegate {
    func didUpdateRestaurant(_ restaurantManager: RestaurantManager, restaurant: [RestaurantModel])
    func didFailWithError(error: Error)
}

struct RestaurantManager {
    //MARK: - Variables
    
    var delegate: RestaurantManagerDelegate?
    let urlAPI: String = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    
    //MARK: - Func
    
    func fetchRestaurant() {
        performRequest(with: urlAPI)
    }
    
    //Fetch
    func performRequest(with urlString: String) {
        if let URL = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: URL) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let restaurants = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRestaurant(self, restaurant: restaurants)
                    }
                }
            }
            task.resume()
        }
    }
    
    //Return data
    func parseJSON(_ restaurantData: Data) -> [RestaurantModel]? {
        let decoder = JSONDecoder()
        var restaurants = [RestaurantModel]()
        do {
            let decodedData = try decoder.decode(RestaurantData.self, from: restaurantData)
            for i in 0..<decodedData.restaurants.count {
                let restaurantIndex = decodedData.restaurants[i]
                //primary data
                var name: String = ""
                var category: String = ""
                var image: String = ""

                if let nameSafe = restaurantIndex.name {
                    name = nameSafe
                }
                
                if let categorySafe = restaurantIndex.category {
                    category = categorySafe
                }
                
                if let imageSafe = restaurantIndex.backgroundImageURL {
                    image = imageSafe
                }
                
                //contact data
                var phoneNumber: String = ""
                var twitter: String = ""
                if let contactSafe = restaurantIndex.contact {
                    if let phone = contactSafe.formattedPhone {
                        phoneNumber = phone
                    }
                    if let twit = contactSafe.twitter {
                        twitter = twit
                    }
                }
                
                //adress data
                var adress: [String] = [""]
                var latitude: Double = 0.0
                var longitude: Double = 0.0
                
                if let locationSafe = restaurantIndex.location {
                    if let locat = locationSafe.formattedAddress {
                        adress = locat
                    }
                    
                    if let lat = locationSafe.lat {
                        latitude = lat
                    }
                    
                    if let lon = locationSafe.lng {
                        longitude = lon
                    }
                }
                
                //init
                let restaurant = RestaurantModel(na: name, ca: category, im: image, ph: phoneNumber, tw: twitter, ad: adress, lati: latitude, long: longitude)
                
                restaurants.append(restaurant)
            }
            return restaurants
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


