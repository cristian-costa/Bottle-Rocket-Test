//
//  CustomCollectionViewCell.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var categoryTypeName: UILabel!
    @IBOutlet weak var imgRestaurant: CustomImageView!
    
    //MARK: - Functions
    
    func configure(restaurant: String, category: String){
        restaurantName.text = restaurant
        categoryTypeName.text = category
    }
    
}
