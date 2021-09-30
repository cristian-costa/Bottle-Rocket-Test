//
//  MapViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 29/09/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //MARK: - IBOutlet
    
    @IBOutlet private weak var mapView: MKMapView!
    var locations: [[Double]]?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMap()
    }
    
    //MARK: - IBActions
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    private func updateMap() {
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)

        if let locationsSafe = locations {
            for i in 0..<locationsSafe.count {
                let location = CLLocationCoordinate2D(latitude: locationsSafe[i][0], longitude: locationsSafe[i][1])
                let region = MKCoordinateRegion(center: location, span: span)

                let pin = MKPointAnnotation()
                pin.coordinate = location

                mapView.setRegion(region, animated: true)
                mapView.addAnnotation(pin)
            }
        }
    }
}

