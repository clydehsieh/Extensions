//
//  UICollectionView+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

extension UICollectionReusableView {
    static var className: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func register(cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.className)
    }
    
    func register(headerClass: UICollectionReusableView.Type) {
        register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerClass.className)
    }
    
    func register(footerClass: UICollectionReusableView.Type) {
        register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerClass.className)
    }
    
}

extension UICollectionView {
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T>(for item: Int) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: IndexPath(item: item, section: 0)) as! T
    }
    
    func dequeueReusableSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderView<T>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    func dequeueReusableFooterView<T>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionFooter
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
}
