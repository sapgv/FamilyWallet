//
//  Application.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 25/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

final class Application {
    
    static let shared = Application()
    private init() {}
    
    func configure(in window: UIWindow) {
    
        let walletCollectionViewController = WalletCollectionViewController.instance()
        let naviagtionController = UINavigationController(rootViewController: walletCollectionViewController)
        
        
        
        
        
        window.rootViewController = naviagtionController
        window.makeKeyAndVisible()
        
        
    }
    
    func run() {
        
        let walletCollectionViewController = WalletCollectionViewController.instance()
        let naviagtionController = UINavigationController(rootViewController: walletCollectionViewController)
        
        
        
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = naviagtionController
        window.makeKeyAndVisible()
        
    }
    
    
    
    
    
}
