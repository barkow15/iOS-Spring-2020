//
//  TableController.swift
//  FirebaseHelloWorld
//
//  Created by Philip Thomas Barkow on 14/03/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if posts[indexPath.row].hasImage() {
            if let cell = myTableView.dequeueReusableCell(withIdentifier: "cell2") as? CellWithTextAndImage {
                cell.myLabel.text = posts[indexPath.row].text
                CloudStorage.downloadImage(name: posts[indexPath.row].image, image: cell.myImageView)
                return cell
            }
        } else {
            if let cell = myTableView.dequeueReusableCell(withIdentifier: "cell1") as? CellWithText {
            cell.myLabel.text = posts[indexPath.row].text
            return cell
        }
    }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        posts.append(Post(txt: "Nice car!", img: ""))
        posts.append(Post(txt: "This is my car", img: "car.jpg"))
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
}
