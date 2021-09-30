//
//  RestaurantModel.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit

class RestaurantModel {
    //MARK: - Variables
    
    private let name: String
    private let category: String
    private let image: String
    private let phone: String
    private let twitter: String
    private let adress: [String]
    private let lat: Double
    private let lng: Double
    
    //MARK: - Init
    
    init(na: String, ca: String, im: String, ph: String, tw: String, ad: [String], lati: Double, long: Double) {
        name = na
        category = ca
        image = im
        phone = ph
        twitter = tw
        adress = ad
        lat = lati
        lng = long
    }
    
    //MARK: - Getters
    
    func getName() -> String {
        return name
    }
    
    func getCategory() -> String {
        return category
    }
    
    func getImage() -> String {
        return image
    }
    
    func getAdress() -> [String] {
        return adress
    }
    
    func getPhone() -> String {
        return phone
    }
    
    func getTwitter() -> String {
        return twitter
    }
    
    func getLatLng() -> [Double]{
        var latLng: [Double] = []
        latLng.append(lat)
        latLng.append(lng)
        return latLng
    }
}
