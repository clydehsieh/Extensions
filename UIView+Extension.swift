//
//  UIView+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//
import UIKit

public protocol ClassDescribable {
    var className: String { get }
    static var className: String { get }
}

public extension ClassDescribable {
    var className: String {
        return String(describing: type(of: self))
    }
    
    static var className: String {
        return String(describing: self)
    }
}

extension UIView: ClassDescribable {}
