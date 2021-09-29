//
//  RestaurantData.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import Foundation

struct RestaurantData: Codable {
    let restaurants: [Restaurants]
}

struct Restaurants: Codable {
    let name: String?
    let backgroundImageURL: String?
    let category: String?
    let contact: Contact?
    let location: Location?
}

struct Contact: Codable {
    let formattedPhone: String?
    let twitter: String?
}

struct Location: Codable {
    let formattedAddress: [String]?
    let lat: Double?
    let lng: Double?
}
