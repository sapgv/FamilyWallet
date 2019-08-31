//
//  AppDelegate.swift
//  FamilyWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configure(in: window)
        
        self.window = window
//        let frame = UIScreen.main.bounds
//        window = UIWindow(frame: frame)
//        window?.makeKeyAndVisible()
//
//        let walletCollectionViewController = WalletCollectionViewController.instance()
//        let nc = UINavigationController(rootViewController: walletCollectionViewController)
//
//        window?.rootViewController = nc
        return true
    }

}

