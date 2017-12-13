//
//  ImageManager.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 10..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import Foundation
import UIKit

class ImageManager{
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, setImageFor: @escaping (UIImage) -> Void) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                setImageFor(UIImage(data: data)!)
            }
        }
    }
}

extension UIImage {
    func averageColor() -> UIColor? {
        if let cgImage = self.cgImage, let averageFilter = CIFilter(name: "CIAreaAverage") {
            let ciImage = CIImage(cgImage: cgImage)
            let extent = ciImage.extent
            let ciExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
            averageFilter.setValue(ciImage, forKey: kCIInputImageKey)
            averageFilter.setValue(ciExtent, forKey: kCIInputExtentKey)
            if let outputImage = averageFilter.outputImage {
                let context = CIContext(options: nil)
                var bitmap = [UInt8](repeating: 0, count: 4)
                context.render(outputImage,
                               toBitmap: &bitmap,
                               rowBytes: 4,
                               bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                               format: kCIFormatRGBA8,
                               colorSpace: CGColorSpaceCreateDeviceRGB())
                
                return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                        green: CGFloat(bitmap[1]) / 255.0,
                        blue: CGFloat(bitmap[2]) / 255.0,
                        alpha: 1.0)
            }
        }
        return nil
    }
}

extension UIColor {
    
    func contrastColor() -> UIColor{
        let ciColor = CIColor(color: self)
        
        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 1 - ( 0.299 * ciColor.red + 0.587 * ciColor.green + 0.114 * ciColor.blue)/255
        let val : CGFloat = luminance < 0.5 ? 0.0 : 255.0
        return UIColor(red: val, green: val, blue: val, alpha: 1.0)
    }
}
