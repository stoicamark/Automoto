//
//  Slide.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 09..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Slide: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var dynamicCouponIndicator: NVActivityIndicatorView!
    @IBOutlet weak var serial: UILabel!
    @IBOutlet weak var saving: UILabel!
    @IBOutlet weak var couponImage: UIImageView!
    
    @IBOutlet weak var barcodeImage: UIImageView!
}
