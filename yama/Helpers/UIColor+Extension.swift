//
//  UIColor+Extension.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //Blue
    static let iceBlue = UIColor(hexValue: "E1F5FF")
    static let darkBlue = UIColor(hexValue: "1E2B31", alpha: 0.8)
    static let filterBlue = UIColor(hexValue: "091920", alpha: 0.5)
    
    //Black
    static let backgroundBlack = UIColor(hexValue: "1B1B1B")
    static let overviewBlack = UIColor(hexValue: "383838")
    
    
    /// UIColor does not provide an out-of-the-box constructor for hex values.
    /// This aims to fix that.
    convenience init(hexValue: String, alpha: Float = 1.0){
        let scanner = Scanner(string:hexValue)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
