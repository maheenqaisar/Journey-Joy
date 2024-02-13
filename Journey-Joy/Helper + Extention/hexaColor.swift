//
//  hexaColor.swift
//  SixApp
//
//  Created by Talha on 02/03/2021.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var cleanedHexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedHexString.hasPrefix("#") {
            cleanedHexString.remove(at: cleanedHexString.startIndex)
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: cleanedHexString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let rgb = (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
        
        return String(format: "#%06x", rgb)
    }
}
