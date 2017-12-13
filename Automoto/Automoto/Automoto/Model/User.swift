//
//  User.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 13..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import Foundation
import UIKit

class User{
    var id : String?
    var name : String?
    var email : String?
    var picture : UIImage?
    
    init(id: String, name: String, email: String, pictureUrl: String?){
        self.id = id
        self.name = name
        self.email = email
        
        let imageManager = ImageManager()
        if let pictureUrl = pictureUrl{
            if let url = URL(string: pictureUrl) {
                imageManager.downloadImage(url: url, setImageFor: {image in
                    self.picture = image
                })
            }
        }
    }
}
