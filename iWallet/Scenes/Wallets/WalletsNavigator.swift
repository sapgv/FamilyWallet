//
//  WalletsNavigator.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 04/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol WalletsNavigator {
    
    func wallets()
    func createWallet()
    
}

final class DefaultWalletsNavigator: WalletsNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func wallets() {
        
        let viewModel = WalletsViewModel(navigator: self)
        let walletsCollectionViewController = WalletsCollectionViewController.instance()
        walletsCollectionViewController.viewModel = viewModel
        navigationController.pushViewController(walletsCollectionViewController, animated: true)
        
    }
    
    
    func createWallet() {
        
        let navigator = DefaultAddWalletNavigator(navigationController)
        let viewModel = AddWalletViewModel(navigator: navigator)
        let viewController = storyboard.instatiateViweController(from: AddWalletViewController.self)
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
