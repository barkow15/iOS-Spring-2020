//
//  FirstViewController.swift
//  ios_nodejs_examproject
//
//  Created by Philip Barkow on 14/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import FontAwesome_swift
import CoreLocation

class WelcomePageViewController: UIViewController {
    @IBOutlet weak var uiLoginButton: UIButton!
    @IBOutlet weak var uiIWelcomeMessageLabel: UILabel!
    weak var facebookManager:FacebookManager?
    var firebaseManager:FirebaseManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set welcome message
        if facebookManager != nil{
            let fbFirstName = self.facebookManager?.fbProfileInfo?.name
            
            self.uiIWelcomeMessageLabel.text = "Good to see you here \(fbFirstName ?? "")!"
        }
    
        // Init firebase manager
        self.firebaseManager = FirebaseManager(parentVC: self)
        
        // Config logout button
        let uiLoginButton = self.uiLoginButton
        uiLoginButton?.setImage(UIImage.fontAwesomeIcon(name: .signOutAlt, style: .solid, textColor: .systemBlue, size: CGSize(width: 30, height: 30)), for: .normal)
        uiLoginButton?.setTitle("Logout ", for: UIControl.State.normal)
        uiLoginButton?.titleLabel?.font = .systemFont(ofSize: 16)
        uiLoginButton?.semanticContentAttribute = .forceRightToLeft
        
    }
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        if self.firebaseManager.signOut() {
            print("User logged out")
        }else{
            print("Could not log user out")
        }
        
        
    }
    

}

