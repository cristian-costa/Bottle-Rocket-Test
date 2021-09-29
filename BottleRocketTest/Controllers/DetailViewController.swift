//
//  detailViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 28/09/2021.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    var restaurant: RestaurantModel?
    
    //MARK: - IBOutlet
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var adress: UILabel!
    @IBOutlet private weak var cityState: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var twitter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMap()
        updateUI()
    }
    
    func updateUI(){
        if let restaurantSafe = restaurant {
            restaurantName.text = restaurantSafe.name
            categoryName.text = restaurantSafe.category
            adress.text = restaurantSafe.adress[0]
            if restaurantSafe.adress.count > 0 {
                cityState.text = restaurantSafe.adress[1]
            }
            phone.text = restaurantSafe.phone
            if restaurantSafe.twitter != "" {
                twitter.text = ("@\(restaurantSafe.twitter)")
            } else {
                twitter.text = ""
            }
        }
    }
    
    func updateMap() {
        if let restaurantSafe = restaurant {
            let location = CLLocationCoordinate2D(latitude: restaurantSafe.lat, longitude: restaurantSafe.lng)
            let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            let region = MKCoordinateRegion(center: location, span: span)
            
            let pin = MKPointAnnotation()
            pin.coordinate = location
            
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pin)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
