//
//  UIColor+Extension.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit
extension UIColor {
    /// Initialize a UIColor using a hex string.
    /// - Parameters:
    ///   - hex: The hex string of the color. It can include `#` (e.g., `#FFFFFF` or `FFFFFF`).
    ///   - alpha: The alpha value of the color (optional, default is 1.0).
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        let length = hexSanitized.count
        if length == 6 {
            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
}
