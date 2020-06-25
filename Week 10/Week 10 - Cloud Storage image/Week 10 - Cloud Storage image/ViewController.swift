//
//  ViewController.swift
//  Week 10 - Cloud Storage image
//
//  Created by Philip Barkow on 25/06/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var headline: UITextView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var imageText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var rowNumber = 0
    
    @IBAction func btnClicked(_ sender: UIBarButtonItem) {
        CloudStorage.createNote(head: headline.text, body: body.text, image: imageText.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let note = CloudStorage.getNoteAt(index: rowNumber)
        headline.text = note.head
        body.text = note.body
        if note.image != "empty" {
            imageText.text = note.image; CloudStorage.downloadImage(name: note.image, image: imageView)
        } else {
            print("image is empty")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoAction(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else {
            return
        }
        print(image.size)
        dismiss(animated: true)
        CloudStorage.uploadImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    

}

struct Note{
    var id: String
    var head: String
    var body: String
    var image: String
}
