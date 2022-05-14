//
//  Color+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//
import UIKit

//MARK: - RGB
extension UIColor {
   convenience init(r: Int, g: Int, b: Int) {
       self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
   }

   convenience init(rgb: Int) {
       self.init(
           r: (rgb >> 16) & 0xFF,
           g: (rgb >> 8) & 0xFF,
           b: rgb & 0xFF
       )
   }

   convenience init(w: Int) {
       self.init(r: w, g: w, b: w)
   }

   static var randomLight: UIColor {
       return UIColor(
           r: 240 - Int(arc4random_uniform(40)),
           g: 240 - Int(arc4random_uniform(40)),
           b: 240 - Int(arc4random_uniform(40))
       )
   }

   static var randomDark: UIColor {
       return UIColor(
           r: 15 + Int(arc4random_uniform(40)),
           g: 15 + Int(arc4random_uniform(40)),
           b: 15 + Int(arc4random_uniform(40))
       )
   }
}

//MARK - Hex
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        var tempHex = hex
        if tempHex.hasPrefix("#") {
            tempHex.remove(at: tempHex.startIndex)
        }
        let scanner = Scanner(string: tempHex)
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xFF0000) >> 16
        let green = (rgbValue & 0xFF00) >> 8
        let blue = rgbValue & 0xFF
        
        self.init(
            red: CGFloat(red) / 0xFF,
            green: CGFloat(green) / 0xFF,
            blue: CGFloat(blue) / 0xFF, alpha: alpha
        )
    }
}

//MARK: - random
extension UIColor {
    public class var random: UIColor {
        func random() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
        
        return UIColor(
            red: random(),
            green: random(),
            blue: random(),
            alpha: 1.0
        )
    }
}

