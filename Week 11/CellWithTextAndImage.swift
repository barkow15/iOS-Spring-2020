//
//  CellWithTextAndImage.swift
//  FirebaseHelloWorld
//
//  Created by Philip Thomas Barkow on 14/03/2020.
//  Copyright © 2020 Philip Barkow. All rights reserved.
//

import UIKit

class CellWithTextAndImage: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
