//
//  ViewController.swift
//  Week_12_MapLocation
//
//  Created by Philip Barkow on 20/03/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()// Ask user to approve location sharing with app
        locationManager.startUpdatingLocation() // Start getting location data from device in a continous stream
        // createDemoMarker()
        let marker = MKPointAnnotation()
        marker.title = "Go here"
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        map.addAnnotation(marker)
        
        FirebaseRepo.startListener(vc: self)
    }
    
    func updateMarkers(markers: [MKPointAnnotation]){
        print("Updating markers...")
        // make a loop, iterating through the markers list
        
        let markers = Map.getMK // Call adapter to convert data
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
    fileprivate func createDemoMarker(){
        let marker = MKPointAnnotation() // Create an empty marker
        marker.title = "Go here" // Message on the marker
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        map.addAnnotation(marker)
        
    }

}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("new location \(locations.first?.coordinate)")
        
        if let coordinate = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true)
        }
    }
}

