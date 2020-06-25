//
//  ViewController.swift
//  Sensors
//
//  Created by Philip Barkow on 30/04/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    let pedometer = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        startBtn.setTitle("Tracking", for: .normal)
        pedometer.startUpdates(from: Date()) {
            (data, error) in
            DispatchQueue.main.async {
                if (error == nil) {
                    
                    var toDisplay = ""
                    let temp = data?.distance?.stringValue
                    for index in 0...temp!.count {
                        if (temp![index] == ".") {
                            for number in 0...index+2 {
                                toDisplay.append(temp![number])
                            }
                            self.distanceLabel.text = toDisplay
                            break
                        }
                    }
                    
                    self.stepsLabel.text = data?.numberOfSteps.stringValue
                }else{
                    print(error)
                }
            }
        }
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        startBtn.setTitle("Start", for: .normal)
        pedometer.stopUpdates()
    }
    

    @IBAction func comfirmBtnPressed(_ sender: Any) {
        // Handle send to Firebase here
        distanceLabel.text = "0"
        stepsLabel.text = "0"
    }
    
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

