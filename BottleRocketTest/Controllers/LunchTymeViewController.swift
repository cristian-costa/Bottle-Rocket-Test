//
//  LunchTymeViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit

class LunchTymeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Variables
    
    var restaurantManager = RestaurantManager()
    var restaurantsArray = [RestaurantModel]()
    private let reuseIdentifier = "Cell"
    private let segueDetails = "goToDetails"
    private let segueMap = "goToMap"

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantManager.delegate = self
        restaurantManager.fetchRestaurant()
    }
    
    //MARK: - CollectionView DataSource Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    //Display cells in the Collection View
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let safeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell {
            let name = restaurantsArray[indexPath.row].getName()
            let category = restaurantsArray[indexPath.row].getCategory()
            if let safeURL = URL(string: restaurantsArray[indexPath.row].getImage()) {
                safeCell.imgRestaurant.loadImage(from: safeURL)
            }
            safeCell.configure(restaurant: name, category: category)
            cell = safeCell
        }
        return cell
    }
    
    //Set Responsive Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if view.frame.width <= 428 {
            return CGSize(width: view.frame.width, height: 180)
        } else {
            return CGSize(width: view.frame.width/2, height: 180)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    //MARK: - CollectionView Delegate Methods
    
    //Segue go to DetailViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueDetails, sender: self)
    }
    
    //MARK: - Prepare Segues
    
    //Segue go to MapViewController
    @IBAction func mapBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueMap, sender: self)
    }
    
    //Prepare segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetails {
            let destinationVC = segue.destination as! DetailViewController
            let indexPaths: NSArray = collectionView.indexPathsForSelectedItems! as NSArray
            let indexPath: IndexPath = indexPaths[0] as! IndexPath
            destinationVC.restaurant = restaurantsArray[indexPath.row]
        }
        
        if segue.identifier == segueMap {
            let destinationVC = segue.destination as! MapViewController
            var locations: [[Double]] = []
            for i in 0..<restaurantsArray.count {
                locations.append(restaurantsArray[i].getLatLng())
            }
            destinationVC.locations = locations
        }
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
