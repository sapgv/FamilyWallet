//
//  TabsNavigator.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 17/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol TabsNavigator {
    func toTabs()
}

final class DefaultTabsNavigator: TabsNavigator {
    
    private let storyboard: UIStoryboard
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toTabs() {
        
        let walletsNavigator = DefaultWalletsNavigator(navigationController: navigationController, storyboard: storyboard)
        let walletsUseCase = WalletsUseCase()
        let walletsViewModel = WalletsViewModel(navigator: walletsNavigator, walletsUseCase: walletsUseCase)
        let walletsCollectionViewController = WalletsCollectionViewController.instance()
        walletsCollectionViewController.viewModel = walletsViewModel
        
        let settingsNavigator = DefaultSettingsNavigator(navigationController: navigationController, storyboard: storyboard)
        let settingsViewController = SettingsViewController()
        let settingsViewModel = SettingsViewModel()
        settingsViewController.viewModel = settingsViewModel
        
        
        let tabsViewController = UITabBarController()
        tabsViewController.setViewControllers([walletsCollectionViewController, settingsViewController], animated: true)
        
        tabsViewController.tabBar.items?[0].title = "Wallets".localized
        tabsViewController.tabBar.items?[0].image = UIImage(named: "wallet")
        
        tabsViewController.tabBar.items?[1].title = "Settings".localized
        tabsViewController.tabBar.items?[1].image = UIImage(named: "settings")
        
        navigationController.pushViewController(tabsViewController, animated: true)
        
        
    }

    
}
