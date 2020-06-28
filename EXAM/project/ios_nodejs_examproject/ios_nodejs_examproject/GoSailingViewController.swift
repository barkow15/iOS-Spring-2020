//
//  SecondViewController.swift
//  ios_nodejs_examproject
//
//  Created by Philip Barkow on 14/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class GoSailingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var uiMap: MKMapView!
    @IBOutlet weak var uiTitleLabel: UILabel!
    @IBOutlet weak var uiInitLocationTrackingButton: UIButton!
    @IBOutlet weak var uiSubtitleTextView: UITextView!
    
    // Create Const CLLocationManager
    var locationManager:CLLocationManager!
    var firebaseManager:FirebaseManager!
    var daysBySeaFirebaseModel = DaysBySeaFirebaseModel()
    var locationTrackingStatus = false
    // Use a set because we don't want the coordinates ordered and we want values to be unique
    var locationsTracked = [[Any]]()
    var listOfGPSLocations = [GPSLocation]()
    var listOfGPSLocationsForUIMap:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init locationmanager
        self.locationManager = CLLocationManager()
        
        // Init firebasemanager
        self.firebaseManager = FirebaseManager(parentVC: self)
        
        // Config og play/stop button //
        uiInitLocationTrackingButton.setImage(UIImage.fontAwesomeIcon(name: .playCircle, style: .regular, textColor: UIColor.systemBlue, size: CGSize(width: 100, height: 100)), for: .normal)
        
        // Config of uiMap //
        self.uiMap.delegate = self
        self.uiMap.mapType = MKMapType(rawValue: 0)!
        self.uiMap.isZoomEnabled = true
        self.uiMap.isScrollEnabled = true
        
        // Config of locationManager //
        // Setup VC as delegate
        self.locationManager.delegate = self
        
        // Prompt user for request location always
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter = 2
    }
    
    @IBAction func btnInitLocationTrackingPressed(_ sender: UIButton) {
        self.toggleLocationTracking()
    }
    
//    func addPolylineToMap(locations: [CLLocation]) {
//        let coordinates = locations.map { $0.coordinate }
//        let geodesic = MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count)
//        self.uiMap.add(geodesic)
//    }
    
    fileprivate func resetGPSData() {
        // Reset datastructures
        self.locationsTracked.removeAll()
        self.listOfGPSLocationsForUIMap.removeAll()
        self.listOfGPSLocations.removeAll()
    }
    
    func toggleLocationTracking(){
        if(locationTrackingStatus == false){
            // Change button icon to Play
            uiInitLocationTrackingButton.setImage(UIImage.fontAwesomeIcon(name: .stopCircle, style: .regular, textColor: UIColor.systemBlue, size: CGSize(width: 100, height: 100)), for: .normal)
            
            // Change uiTitleLabel text
            self.uiTitleLabel.text = "Smooth sailing skipper!"
            // Change uiSubtitleTextView text
            self.uiSubtitleTextView.text = "Voyage en route! Now recording data of your travels.\n(Please be safe & remember a life west)"
            
            // Show location pin
            self.uiMap.showsUserLocation = true;
            
            
            self.locationManager.startUpdatingLocation()
            print("Started tracking location")
            
            self.locationTrackingStatus = true;
        }else if(locationTrackingStatus == true){
            // Change uiTitleLabel text
            self.uiTitleLabel.text = "Feeling adventurous?"
            // Change uiSubtitleTextView text
            self.uiSubtitleTextView.text = "Start recording data for your next voyage by clicking on the play button"
            
            self.locationTrackingStatus = false;
            print("Stopped tracking location")
            
            // Disable user location
            self.uiMap.showsUserLocation = false;

            
            // If any locationsTracked remains
            if(self.locationsTracked.count > 0){
                // Send request to server to save the last locations
            }
            // Stop updating Location
            self.locationManager.stopUpdatingLocation()
            
            // Change button icon back to play
            self.uiInitLocationTrackingButton.setImage(UIImage.fontAwesomeIcon(name: .playCircle, style: .regular, textColor: UIColor.systemBlue, size: CGSize(width: 100, height: 100)), for: .normal)
            
//            self.firebaseManager.createDayBySea(date: Date.init(), coordinates: self.listOfGPSLocationsForUIMap)
            
            // Resets the data so another voyage may begin
            self.resetGPSData()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // Handle centering on current location
        for currentLocation in locations{
            // Send request to db whenever the count
            if(listOfGPSLocations.count == 5){
                print("Tracked 5 locations sending request to server")
                print(listOfGPSLocations)
                //let jsonData = try? JSONSerialization.data(withJSONObject: locationsTracked)

                let jsonData = try! JSONEncoder().encode(listOfGPSLocations)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                print(jsonString)
                
                // create post request
                //let url = URL(string: "http://ec2-54-172-76-20.compute-1.amazonaws.com/gps/track/")!
                let url = URL(string: "http://localhost:3000/gps/emitlocation")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"

                // insert json data to the request
                request.httpBody = jsonData

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                    }
                }

                task.resume()
                
                
                listOfGPSLocations.removeAll()
            }
            
            // Handle begin drawing polyline
            /*
            let polyLine = MKPolyline(coordinates: listOfGPSLocationsForUIMap, count: listOfGPSLocationsForUIMap.count)
            self.uiMap?.addOverlay(polyLine)
            print(listOfGPSLocationsForUIMap)
            */
            
            /*
            let coordinatePtr = UnsafeMutablePointer<CLLocationCoordinate2D>(mutating: listOfGPSLocationsForUIMap)
            let trackPolygon = MKPolyline(coordinates: coordinatePtr, count: listOfGPSLocationsForUIMap.count)
            uiMap.removeOverlays(uiMap.overlays)
            
            uiMap.addOverlay(trackPolygon)
            */
//            createOrUpdatePolyline(mapView: self.uiMap, coordinates: self.listOfGPSLocationsForUIMap, currentlocation: <#T##CLLocationCoordinate2D#>)
            
            // Build data structure for submitting to node.js application
            let locationCoordinate = [Double(currentLocation.coordinate.latitude), Double(currentLocation.coordinate.longitude)]
            
            locationsTracked.append(locationCoordinate);
            print(locationCoordinate)
            //print("Latitude is \(currentLocation.coordinate.latitude) : Longitude is \(currentLocation.coordinate.longitude)")

            let gpsLocation = GPSLocation(lat: Double(currentLocation.coordinate.latitude), lng: Double(currentLocation.coordinate.latitude))
            
            listOfGPSLocations.append(gpsLocation)
            listOfGPSLocationsForUIMap.append(CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)) // For being able to use when rendering polyline
            
            if let currentLocation = locations.last{
                
                let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                
                createOrUpdatePolyline(mapView: self.uiMap, coordinates: self.listOfGPSLocationsForUIMap, currentlocation: center)
            }

        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.systemBlue
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }else{
            return MKOverlayRenderer()
        }
    }
    
    func createOrUpdatePolyline(mapView:MKMapView, coordinates:[CLLocationCoordinate2D], currentlocation:CLLocationCoordinate2D) {
        // Clear overlays before drawingnew ones
//        mapView.removeOverlays(mapView.overlays)
        
        let geodesic = MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(geodesic)

        
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region1 = MKCoordinateRegion(center: currentlocation, span: span)
        mapView.setRegion(region1, animated: true)

    }
    
    public struct GPSLocation: Codable {
        var lat : Double
        var lng : Double
    }
}

