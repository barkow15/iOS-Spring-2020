//
//  ViewController.swift
//  MyNotebook
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var theText = "";
    var index = 0;
    var beingEdited = false
    var textArray = [String]() // we initialize an empty String array
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    let defaultNoteVals = ["Note 1", "Note 2"]
    
    let file = "notes.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for defaultNote in defaultNoteVals {
            textArray.append(defaultNote)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }
    
    @IBAction func deleteIndex(_ sender:  UIButton) {
        if beingEdited {
            textArray.remove(at: index)
            beingEdited = false
            textView.text = ""
        }
        tableView.reloadData()
    }

    @IBAction func savePressed(_ sender: UIButton) {
        theText = textView.text
        textView.text = "";
        if beingEdited {
            textArray[index] = theText
            beingEdited = false
            
        } else {
            textArray.append(theText)
        }
        tableView.reloadData()
        saveFile(str: theText, fileName: file)
        print(readStringFromFile(fileName: file))
    }
    
    func saveFile(str:String, fileName:String) {
        let filePath = getDocumentDirectory().appendingPathComponent(fileName)
        
        do {
            try str.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
            print("Successfully wrote String:\("'" + str + "'") to file. File resides in: \(filePath)")
        } catch {
            print("Error writing String:\("'" + str + "'") to file")
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDirectory().appendingPathComponent(fileName)
        do {
            let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch {
            print("Error reading file " + fileName)
        }
        return "";
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") {
            cell.textLabel?.text = textArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beingEdited = true
        textView.text = textArray[indexPath.row]
        index = indexPath.row
    }
    
}
