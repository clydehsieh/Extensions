//
//  UIViewController+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//
import SafariServices

//MARK: - Open URL
extension UIViewController {
    func presentSFSafariViewController(url: URL, animated flag: Bool, completion: (() -> Void)? = nil) {
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            // Can open with SFSafariViewController
            let vc = SFSafariViewController(url: url)
            present(vc, animated: flag, completion: completion)
        } else {
            // Scheme is not supported or no scheme is given, use openURL
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - Notch Screen Detect
extension UIViewController {
    
    /// 原文链接：https://blog.csdn.net/yao1500/article/details/83827710
    /// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
    /// 判断刘海屏，返回true表示是刘海屏
    /// This detection must use it on UI main thread, otherwise will crash the app.
    var isNotchScreen: Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return false
        }
        
        let size = UIScreen.main.bounds.size
        let notchValue: Int = Int(size.width / size.height * 100)
        
        if notchValue == 216 || notchValue == 46 {
            return true
        }
        
        return false
    }
    
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 }).first?.windows
                .filter({ $0.isKeyWindow })
                .first?.safeAreaInsets ?? .zero
        } else {
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            return window?.safeAreaInsets ?? .zero
        }
    }
}

// MARK: - End editing gesture recognizer
extension UIViewController {
    func addTapToDismissKeyboardGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(endViewsEditing))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    func endViewsEditing() {
        view.endEditing(true)
    }
}
