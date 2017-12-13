//
//  ProfileViewController.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 13..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBarcodeImage: UIImageView!
    
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user{
            userImage.image = user.picture
            userImage.layer.cornerRadius = userImage.frame.size.height/2
            userName.text = user.name
            userEmail.text = user.email
            
            if let barcodeImage = Barcode.fromString(string: user.email!){
                userBarcodeImage.image = barcodeImage
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
