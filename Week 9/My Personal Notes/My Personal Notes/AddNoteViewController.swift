//
//  AddNoteViewController.swift
//  My Personal Notes
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    
    @IBOutlet weak var noteHeader: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    @IBAction func btnClicked(_ sender: UIButton) {
        CloudStorage.createNote(head: noteHeader.text!, body: noteContent.text)
        let alert = UIAlertController(title: "Note created", message: "", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

