//
//  FacebookManager.swift
//  FacebookLoginApp
//
//  Created by Philip Barkow on 03/04/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class FacebookManager{
    var parentVC:UIViewController
    var authenticated:Bool
    var fbProfileInfo:fbProfile?
    let fireBaseManager:FirebaseManager
    
    
    init(parentVC: UIViewController, fireBaseManager: FirebaseManager){
        self.parentVC = parentVC
        self.fireBaseManager = fireBaseManager
        self.authenticated = false
    }
    
    func loginToFacebook(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: parentVC){ (result) in
            if result != nil{
                switch result{
                    case let .success(granted: _, declined: _, token: token):
                        print("Facebook login success \(token.tokenString)")
                        
                        self.fireBaseManager.signInUsingFacebook(tokenString: token.tokenString) // Login to Firebase via Facebook
                        
                        self.makeGraphRequest()
                        
                    break
                    
                    case .cancelled:
                        print("Login was cancelled");
                    break
                    
                    case .failed(let error) :
                        print("Login failed \(error.localizedDescription)")
                    break
                }
            }else{
                print("failed to login to facebook")
            }
            
        }
    }
    
    func makeGraphRequest(){
//        var fbProfileRet:fbProfile!
        
        if let tokenStr = AccessToken.current?.tokenString{
            let graphRequest = GraphRequest(
                graphPath: "/me",
                parameters: ["fields":"id,name,email,picture.width(200)"],
                tokenString: tokenStr,
                version: Settings.defaultGraphAPIVersion,
                httpMethod: .get)
            let connection = GraphRequestConnection()
            
            connection.add(graphRequest){ (connection, result, error) -> Void in
                if error == nil, let res = result{

                    
                    let dict = res as! [String:Any]
                    let id   = dict["id"] as! String
                    let name = dict["name"] as! String
                    let imageDict = dict["picture"] as! [String:Any]
                    let imageDictData = imageDict["data"] as! [String:Any]
                    let imageURL = imageDictData["url"] as! String
                    let email = dict["email"] as! String
                    
//                    print("got data from facebook \(imageURL)")
                    self.fbProfileInfo = fbProfile(id: id , name: name,email: email, profilePictureUrl:imageURL)
                    print(self.fbProfileInfo!)
//                    fbProfileRet = fbProfile(id: id , name: name, imageURL: imageURL["url"]!, email: email)
                }else{
                    print("Error getting data from Facebook \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }

    struct fbProfile {
        var id: String!
        var name: String!
        var email: String!
        var profilePictureUrl: String!
    }
}
