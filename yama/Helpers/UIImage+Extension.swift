//
//  UIImage+Extension.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import UIImageColors

extension UIImage {

    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    
    /// UIImageColors don't seem to provide an extension. This is it.
    func getPredominantColors(_ completion: @escaping (UIImageColors) -> Void) {
        self.getColors() {
            completion($0)
        }
    }
}
