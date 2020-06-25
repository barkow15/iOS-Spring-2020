//
//  ViewController2.swift
//  My Personal Notes
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableArray = [String]()
    var preload = ["1", "2", "3"]
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = tableArray[indexPath.row]
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        for e in preload {
            tableArray.append(e)
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func btnClicked(_ sender: UIButton) {
        
    }
    
    // Cancels the seque to show homepage as popup
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
}
