//
//  FirebaseRepo.swift
//  Week_12_MapLocation
//
//  Created by Philip Barkow on 20/03/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo{
    private static let db   = Firestore.firestore() // gets the Firebase instance
    private static let path = "locations" // Sets path to Firebase Collection
    
    static func startListener(vc: ViewController){
        print("Firebase listener started")
        
        db.collection(path).addSnapshotListener{(snap,error) in
            if error != nil {
                return
            }
            if let snapVal = snap { // we check if snap has value
                print(snapVal)
                for doc in snap!.documents {
                    print("recived data")

                    let map = doc.data()
                    print(map)
                    let text = map["text"] as! String
                    let geoPoint = map["coordinates"] as! GeoPoint
                    print(geoPoint)
                }
            }else{
                print("No snap retrieved")
            }
        }
    }
 
}
