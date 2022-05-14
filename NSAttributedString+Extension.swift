//
//  Int+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

@resultBuilder
struct AttributedStringBuilder {
    /// attrAll = NSAttributedString { attr1 attr2 attr3 ...}
    static func buildBlock(_ strings: NSAttributedString...) -> NSAttributedString {
        strings.reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
}

extension NSAttributedString {
    convenience init(@AttributedStringBuilder _ build: () -> NSAttributedString) {
        self.init(attributedString: build())
    }
}

extension NSAttributedString {
    func applied(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let length = (string as NSString).length
        let range = NSRange(location: 0, length: length)
        mutable.addAttributes(attributes, range: range)
        return mutable
    }
    
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        applied(attributes: [.foregroundColor: color])
    }
    
    func font(_ font: UIFont) -> NSAttributedString {
        applied(attributes: [.font: font])
    }
    
    func paragraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        applied(attributes: [.paragraphStyle: style])
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        applied(attributes: [.baselineOffset: offset])
    }
    
    func underlineStyle(_ style: NSUnderlineStyle) -> NSAttributedString {
        applied(attributes: [.underlineStyle: style.rawValue])
    }
    
    func strikethroughStyle(_ style: NSUnderlineStyle) -> NSAttributedString {
        applied(attributes: [.strikethroughStyle: style.rawValue])
    }
    
    func link(url: URL) -> NSAttributedString {
        applied(attributes: [.link: url])
    }
    
    func lineHeight(_ height: CGFloat) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = height
        style.maximumLineHeight = height
        return applied(attributes: [.paragraphStyle: style])
    }
}

