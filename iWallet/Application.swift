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
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()
        let walletsNavigator = DefaultWalletsNavigator(navigationController: navigationController, storyboard: storyboard)
        walletsNavigator.wallets()
        
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        
    }
    
}
