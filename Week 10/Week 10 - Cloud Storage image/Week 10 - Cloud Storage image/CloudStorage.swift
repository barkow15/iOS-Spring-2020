//
//  CloudStorage.swift
//  Week 10 - Cloud Storage image
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage() // get the instance
    private static let notes = "week10notes"
    private static let storageRef = storage.reference()
    
    static func uploadImage(image:UIImage) {
        let storageRef = storage.reference().child("myImage.png")
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil)
        }
    }
    
    static func downloadImage(name:String, image:UIImageView) {
        let imgRef = storage.reference(withPath: name) // get filehandle
        imgRef.getData(maxSize: 4000000) { (data, error) in
            print("success downloading image!")
            // now set the image using vc
            let img = UIImage(data: data!)
            DispatchQueue.main.async {
                image.image = img
            } // telling the operating system, that this task should be done in parralel with whatever it's doing, so it shouldn't be blocking other tasks. It prevents the background thread from blocking the main thread
            
        } // this is possible if the last parameters is a closure, and we dont specify the parameter type because it's already defined in the method call
    }
    
    static func startListener(tableView:UITableView) {
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error)  in
            if error == nil {
                self.list.removeAll() // clears the list
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    
                    // this way we can change the image text to "empty" if the value returns nil
                    let image = map["image"] as? String ?? "empty"
                    let newNote = Note(id: note.documentID, head: head, body: body, image: image)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    static func getSize() -> Int {
        return list.count
    }
    
    static func getNoteAt(index:Int) -> Note {
        return list[index]
    }
    
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String, image:String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["image"] = image
        docRef.setData(map)
    }
    
    static func createNote(head:String, body:String, image:String) {
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["image"] = image
        db.collection(notes).addDocument(data: map)
    }
}
