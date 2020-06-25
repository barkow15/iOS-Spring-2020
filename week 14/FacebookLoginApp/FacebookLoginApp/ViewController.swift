//
//  ViewController.swift
//  FacebookLoginApp
//
//  Created by Philip Barkow on 03/04/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var firebaseManager:FirebaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager = FirebaseManager(parentVC: self)
        // Do any additional setup after loading the view.
    }
    
    func presentSecetVC(){
        performSegue(withIdentifier: "secretSegue", sender: self)
    }

    @IBAction func signupButtonPressed(_ sender: UIButton) {
        if let email = usernameField.text, let pwd = passwordField.text { // check if there is enough text
            if email.count > 5 && pwd.count > 5{
                firebaseManager?.signUp(email: email, pwd: pwd)
            }
        }
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        if let email = usernameField.text, let pwd = passwordField.text{
            if email.count > 5 && pwd.count > 5{
                firebaseManager?.signIn(email: email, pwd: pwd)
            }
        }
    }
    @IBAction func signoutPressed(_ sender: UIButton) {
        firebaseManager?.signOut()
    }

    @IBAction func facebookLoginPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func loadFacebookDataPressed(_ sender: UIButton) {
        
    }
}

