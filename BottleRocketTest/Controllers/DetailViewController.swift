//
//  detailViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 28/09/2021.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    //MARK: - IBOutlet
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var adress: UILabel!
    @IBOutlet private weak var cityState: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var twitter: UILabel!
    
    //MARK: - Variables
    
    var restaurant: RestaurantModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMap()
        updateUI()
    }
    
    //MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private
    
    private func updateUI(){
        if let restaurantSafe = restaurant {
            restaurantName.text = restaurantSafe.getName()
            categoryName.text = restaurantSafe.getCategory()
            adress.text = restaurantSafe.getAdress()[0]
            if restaurantSafe.getAdress().count > 0 {
                cityState.text = restaurantSafe.getAdress()[1]
            }
            phone.text = restaurantSafe.getPhone()
            if restaurantSafe.getTwitter() != "" {
                twitter.text = ("@\(restaurantSafe.getTwitter())")
            } else {
                twitter.text = ""
            }
        }
    }
    
    private func updateMap() {
        if let restaurantSafe = restaurant {
            let location = CLLocationCoordinate2D(latitude: restaurantSafe.getLatLng()[0], longitude: restaurantSafe.getLatLng()[1])
            let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            let region = MKCoordinateRegion(center: location, span: span)

            let pin = MKPointAnnotation()
            pin.coordinate = location

            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pin)
        }
    }
}
