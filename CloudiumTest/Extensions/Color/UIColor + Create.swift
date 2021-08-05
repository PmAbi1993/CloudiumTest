//
//  UIColor + Craete.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import UIKit

extension UIColor {
    convenience init(_ hex: Int, alpha: Double = 1.0) {
            self.init(red: CGFloat((hex >> 16) & 0xFF) / 255.0,
                      green: CGFloat((hex >> 8) & 0xFF) / 255.0,
                      blue: CGFloat((hex) & 0xFF) / 255.0,
                      alpha: CGFloat(255 * alpha) / 255)
        }

        convenience init(_ hexString: String, alpha: Double = 1.0) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)

            let red, green, blue: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (red, green, blue) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
            default:
                (red, green, blue) = (1, 1, 0)
            }

            self.init(red: CGFloat(red) / 255,
                      green: CGFloat(green) / 255,
                      blue: CGFloat(blue) / 255,
                      alpha: CGFloat(255 * alpha) / 255)
        }

        convenience init(redColor: CGFloat,
                         greenColor: CGFloat,
                         blueColor: CGFloat,
                         alphaValue: CGFloat = 1) {
            self.init(red: (redColor / 255), green: (greenColor / 255), blue: (blueColor / 255), alpha: alphaValue)
        }
}
