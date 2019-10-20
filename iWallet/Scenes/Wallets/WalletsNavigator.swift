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
    func toEditWallet(wallet: Wallet)
}

final class DefaultWalletsNavigator: WalletsNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func wallets() {
        
        let walletsUseCase = WalletsUseCase()
        let viewModel = WalletsViewModel(navigator: self, walletsUseCase: walletsUseCase)
        let walletsCollectionViewController = WalletsCollectionViewController.instance()
        walletsCollectionViewController.viewModel = viewModel
        navigationController.pushViewController(walletsCollectionViewController, animated: true)
        
    }
    
    
    func createWallet() {
        
        let navigator = DefaultAddWalletNavigator(navigationController)
        let addWalletUseCase = AddWalletUseCase()
        let viewModel = AddWalletViewModel(navigator: navigator, addWalletUseCase: addWalletUseCase)
        let viewController = storyboard.instatiateViweController(from: AddWalletViewController.self)
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toEditWallet(wallet: Wallet) {
        
        let navigator = DefaultEditWalletNavigator(navigationController: navigationController)
        let useCase = EditWalletUseCase()
        let viewModel = EditWalletViewModel(wallet: wallet, useCase: useCase, navigator: navigator)
//        let vc = storyboard.instatiateViweController(from: EditWalletViewController.self)
        let vc = EditWalletViewController(style: .grouped)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
    
//    func toPost(_ post: Post) {
//        let navigator = DefaultEditPostNavigator(navigationController: navigationController)
//        let viewModel = EditPostViewModel(post: post, useCase: services.makePostsUseCase(), navigator: navigator)
//        let vc = storyBoard.instantiateViewController(ofType: EditPostViewController.self)
//        vc.viewModel = viewModel
//        navigationController.pushViewController(vc, animated: true)
//    }
}
