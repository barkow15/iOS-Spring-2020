//
//  FacebookManager.swift
//  FacebookLoginApp
//
//  Created by Philip Barkow on 03/04/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookManager{
    let parentVC:ViewController
    let fireBaseManager:FirebaseManager
    
    init(parent: ViewController, fireBaseManager: FirebaseManager){
        parentVC = parent
        self.fireBaseManager = fireBaseManager
    }
    
    func loginToFacebook(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: parentVC){ (result) in
            if result != nil{
                print("logged in to facebook \(result)")
                
                switch result{
                case .cancelled:
                    print("Login was cancelled");
                break
                        
                
                case .failed(let error) :
                    print("Login failed \(error.localizedDescription)")
                break
                    
                case let .success(granted: _, declined: _, token: token):
                    print("Facebook login success \(token.userID)")
                    
                    self.fireBaseManager.signInUsingFacebook(tokenString: token.tokenString)
                break
                }
            }else{
                print("failed to login to facebook")
            }
            
        }
    }
    
    func makeGraphRequest(){
        if let tokenStr = AccessToken.current?.tokenString{
            let graphRequest = GraphRequest(
                graphPath: "/me",
                parameters: ["fields":"id,name,email, picture.width(400)"],
                tokenString: tokenStr,
                version: Settings.defaultGraphAPIVersion,
                httpMethod: .get)
            let connection = GraphRequestConnection()
            
            connection.add(graphRequest){ (connection, result, error) in
                if error == nil, let res = result{
                    
                    
                    var dict = res as! [String:Any]
                    let name = dict["name"] as! String
                    
                    print("got data from facebook \(name)")
                    print(dict)
                }else{
                    print("Error getting data from Facebook \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
}
