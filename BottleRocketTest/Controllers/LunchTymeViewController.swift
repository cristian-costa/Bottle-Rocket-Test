//
//  LunchTymeViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit

class LunchTymeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var restaurantManager = RestaurantManager()
    var restaurantsArray = [RestaurantModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantManager.delegate = self
        restaurantManager.fetchRestaurant()
    }
    
    //MARK: - CollectionView DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let safeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CustomCollectionViewCell {
            let name = restaurantsArray[indexPath.row].name
            let category = restaurantsArray[indexPath.row].category
            if let safeURL = URL(string: restaurantsArray[indexPath.row].image) {
                safeCell.imgRestaurant.loadImage(from: safeURL)
            }
            safeCell.configure(restaurant: name, category: category)
            cell = safeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if view.frame.width <= 428 {
            return CGSize(width: view.frame.width, height: 180)
        } else {
            return CGSize(width: view.frame.width/2, height: 180)
        }
    }
    
    //MARK: - CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        let indexPaths: NSArray = collectionView.indexPathsForSelectedItems! as NSArray
        let indexPath: IndexPath = indexPaths[0] as! IndexPath
        destinationVC.restaurant = restaurantsArray[indexPath.row]
    }
}

//MARK: - RestaurantManagerDelegate
extension LunchTymeViewController: RestaurantManagerDelegate {
    func didUpdateRestaurant(_ restaurantManager: RestaurantManager, restaurant: [RestaurantModel]) {
        DispatchQueue.main.async {
            self.restaurantsArray = restaurant
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
