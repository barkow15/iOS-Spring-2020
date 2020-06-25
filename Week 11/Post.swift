//
//  Post.swift
//  FirebaseHelloWorld
//
//  Created by Philip Thomas Barkow on 14/03/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import Foundation

class Post {
    
    var text:String = ""
    
    var image:String = ""
    
    init(txt:String, img:String) {
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0 
    }
}
