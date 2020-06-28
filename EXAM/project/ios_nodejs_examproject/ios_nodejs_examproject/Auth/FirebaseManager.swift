//
//  FireBaseManager.swift
//  FacebookLoginApp
//
//  Created by Philip Barkow on 03/04/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseManager{
    var auth = Auth.auth()
    let parentVC:UIViewController
    
    init(parentVC: UIViewController){
        self.parentVC = parentVC
    }
    
    func signUp(email:String, pwd:String) {
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully logged in to Firebase \(result.debugDescription)")
            }else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
    func signIn(email: String, pwd: String){
        auth.signIn(withEmail: email, password: pwd){ (result, error) in
            if error == nil{
                print("successfully logged in to Firebase \(result.debugDescription)")
                
//                self.parentVC.presentSecetVC() // Show secretVC
            }else{
                print("Failed to login to firebase\(result.debugDescription)")
                print("Email/Password used to login: \(email) / \(pwd)")
            }
        
        }
    }
    
    func signInUsingFacebook(tokenString: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        
        auth.signIn(with: credential){ (result, error) in
            if error == nil{
                print("logged in to firebase, using facebook \(result?.description)")
                
            self.parentVC.performSegue(withIdentifier: "frontpageSeg", sender: nil)

            }else{
                print("Failed to login to firebase, using facebook \(error.debugDescription)")
            }
            
        }
    }
 
    func signOut(){
        do{
            try auth.signOut()
        }catch let error{
            print("eror signing out \(error.localizedDescription)")
        }
    }
}
