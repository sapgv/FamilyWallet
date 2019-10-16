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
        
        let navigator = DefaultWalletsNavigator(navigationController: navigationController, storyboard: storyboard)
        let walletsUseCase = WalletsUseCase()
        let viewModel = WalletsViewModel(navigator: navigator, walletsUseCase: walletsUseCase)
        let walletsCollectionViewController = WalletsCollectionViewController.instance()
        walletsCollectionViewController.viewModel = viewModel
        
        let tabsViewController = UITabBarController()
        tabsViewController.setViewControllers([walletsCollectionViewController], animated: true)
        
        tabsViewController.tabBar.items?[0].title = "Wallets".localized
        tabsViewController.tabBar.items?[0].image = UIImage(named: "wallet")
        
        navigationController.pushViewController(tabsViewController, animated: true)
        
        
    }

    
}
