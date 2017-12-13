//
//  Barcode.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 12..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class Barcode {
    
    class func fromString(string : String) -> UIImage? {
        
        
        let data = string.data(using: .ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        return UIImage(ciImage: (filter?.outputImage)!)
    }
}
