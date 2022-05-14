//
//  UITableView+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

extension UITableViewCell {
    static var className: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var className: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func register(cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.className)
    }
    
    func register(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.className)
    }
    
}

extension UITableView {
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T>() -> T where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
    
}
