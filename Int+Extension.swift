//
//  Int+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

//MARK: - String
extension Int {
    func toString() -> String {
        String(self)
    }
    
    /// 5.toString(maxDigits: 1) -> "5"
    /// 10.toString(maxDigits: 1) -> "9+"
    /// 55.toString(maxDigits: 2) -> "55"
    /// 100.toString(maxDigits: 2) -> "99+"
    /// 10000.toString(maxDigits: 4) -> "9999+"
    func toString(maxDigits: Int) -> String? {
        guard maxDigits > 0 else {
            return nil
        }
        
        let maxCount = Int(pow(Double(10), Double(maxDigits)))
        
        if self <= 0 {
            return nil
        } else if self < maxCount {
            return "\(self)"
        } else {
            return "\(maxCount - 1)+"
        }
    }
        
    func toString(numberStyle: NumberFormatter.Style) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        return formatter.string(from: .init(value: self))
    }
    
    func currencyWithoutSymbol(for locale: Locale?) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale ?? Locale(identifier: "zh_TW")
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 0
        return formatter.string(from: .init(value: self))
    }
}

//MARK: - Date time
extension Int {
    ///  second -> (hour, minute, second)
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
      return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}

//MARK: - Drawing
extension Int {
    ///
    var degreeToRadians: CGFloat {
        return CGFloat(self) * CGFloat.pi / 180
    }
}

