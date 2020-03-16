//
//  ViewController.swift
//  helloWorld
//
//  Created by Philip Barkow on 07/02/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterNameBtnPressed(_ sender: Any) {
        
        if let textFieldName = textField.text {
            if textFieldName != ""{
                nameLbl.text = ("Hello " + textFieldName)
            }else{
                nameLbl.text = ("")
            }
        }else{
            print("Error: Could not set variable 'textFieldName'")
        }
        //print("enterNameBtnPressed pressed")
    }
}

