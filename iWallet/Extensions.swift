//
//  Extensions.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit


extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func registerKeyboardHide() {
        let gesturerecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesturerecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gesturerecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    
    static var uuid: String {
        return UUID().uuidString
    }
    
    var localized: String {
        return self.localized()
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
