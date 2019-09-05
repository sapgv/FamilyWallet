//
//  AppDelegate.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configure(in: window)
        
        self.window = window
        return true
    }

}

