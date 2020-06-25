//
//  SecondViewController.swift
//  Week18MandatoryCoronaApp
//
//  Created by Philip Barkow on 01/05/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 55.68507795, longitude: 12.57998085)
        
        mapView.centerToLocation(initialLocation)
        // Do any additional setup after loading the view.
    }
    

}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

