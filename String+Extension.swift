//
//  Int+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

//MARK: - Alphanumerics
extension String {
    var isAlphanumerics: Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9]*$", options: [])
        return regex.numberOfMatches(in: self, range: NSMakeRange(0, count)) > 0
    }
}

//MARK: - Int
extension String {
    func toInt() -> Int? {
        Int(self)
    }
}

//MARK: - localization
extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(args: CVarArg...) -> String {
        return String(format: localized, locale: Locale.current, arguments: args)
    }
    
    func args(_ args: CVarArg...) -> String {
        return String(format: self, locale: Locale.current, arguments: args)
    }
}

//MARK: - Image
extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
    
    var alwaysOriginalImage: UIImage? {
        return image?.withRenderingMode(.alwaysOriginal)
    }
    
    var alwaysTemplateImage: UIImage? {
        return image?.withRenderingMode(.alwaysTemplate)
    }
}

//MARK: - substring
extension String {
    subscript(index: Int) -> String {
        return self[index ..< index + 1]
    }
    
    /// Chatacter before from: will be trimmed
    func substring(from: Int) -> String {
        return self[min(from, count) ..< count]
    }
    
    /// Character after to: will be trimmed
    func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }
    
    subscript(range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (
            lower: max(0, min(count, range.lowerBound)),
            upper: min(count, max(0, range.upperBound))
        ))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
