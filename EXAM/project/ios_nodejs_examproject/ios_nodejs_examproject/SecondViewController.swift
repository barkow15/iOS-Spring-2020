//
//  SecondViewController.swift
//  ios_nodejs_examproject
//
//  Created by Philip Barkow on 14/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {

    // Create Const CLLocationManager
    let locationManager:CLLocationManager = CLLocationManager()
    var locationTrackingStatus = false
    // Use a set because we don't want the coordinates ordered and we want values to be unique
    var locationsTracked = [[Any]]()
    var listOfGPSLocations = [GPSLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnInitLocationTracking(_ sender: UIButton) {
        if(locationTrackingStatus == false){
            // Setup VC as delegate
            locationManager.delegate = self
            
            // Prompt user for request location always
            
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 2
            
            
            locationManager.startUpdatingLocation()
            print("Started tracking location")
            
            locationTrackingStatus = true;
        }else if(locationTrackingStatus == true){
            locationTrackingStatus = false;
            print("Stopped tracking location")
            
            // If any locationsTracked remains
            if(locationsTracked.count > 0){
                // Send request to server to save the last locations
            }
            // Stop updatigng Location
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations{
            // Send request to db whenever the count
            if(listOfGPSLocations.count == 5){
                print("Tracked 5 locations sending request to server")
            
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

            
            let locationCoordinate = [Double(currentLocation.coordinate.latitude), Double(currentLocation.coordinate.longitude)]
            
            locationsTracked.append(locationCoordinate);
            //print("Latitude is \(currentLocation.coordinate.latitude) : Longitude is \(currentLocation.coordinate.longitude)")

            var gpsLocation = GPSLocation(lat: Double(currentLocation.coordinate.latitude), lng: Double(currentLocation.coordinate.latitude))
            
            listOfGPSLocations.append(gpsLocation)
        }
    }
    
    public struct GPSLocation: Codable {
        var lat : Double
        var lng : Double
    }
}

