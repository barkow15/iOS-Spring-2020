//
//  SelectedNoteViewController.swift
//  MyNotebook
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class SelectedNoteViewController: UIViewController {

    @IBOutlet weak var selectedNoteText: UITextView!
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedNoteText.text = text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
