//
//  CloudStorage.swift
//  My Personal Notes
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit
import Foundation
import FirebaseFirestore

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    
    static func startListener() {
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error)  in
            if error == nil {
                self.list.removeAll() // clears the list
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.list.append(newNote)
                }
            }
        }
    }
    
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
    
    static func createNote(head:String, body:String) {
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        db.collection(notes).addDocument(data: map)
    }
}

struct Note{
    var id: String
    var head: String
    var body: String
}
