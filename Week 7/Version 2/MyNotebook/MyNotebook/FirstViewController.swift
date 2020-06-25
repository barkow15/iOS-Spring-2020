//
//  ViewController.swift
//  MyNotebook
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var noteText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        noteText.delegate=self
        noteText.becomeFirstResponder()
    }
    @IBAction func clearTextFieldBtnPressed(_ sender: Any) {
        noteText.text = ""
    }
    @IBAction func createNoteBtnPressed(_ sender: Any) {
        if noteText.text != "" && noteText != nil{
            print("Create note MyNotebook. \(noteText.text!)")
            
            noteText.resignFirstResponder() // Hide the keyboard when pressing "Create note"
        }else{
            print("No text found in the noteText textfield or noteText is nil")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // Resign keyboard on submit
        noteText.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        noteText.resignFirstResponder()
    }
    
}

