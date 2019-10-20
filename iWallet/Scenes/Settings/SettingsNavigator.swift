//
//  SettingsNavigator.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 17/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsNavigator {
    var storyboard: UIStoryboard { get }
    var navigationController: UINavigationController { get }
    func toSettings()
}

final class DefaultSettingsNavigator: SettingsNavigator {
    
    internal let storyboard: UIStoryboard
    internal let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toSettings() {
        
        let settingsUseCase = SettingsUseCase()
        let viewModel = SettingsViewModel(navigator: self, settingsUseCase: settingsUseCase)
        let settingsViewController = SettingsViewController()
        settingsViewController.viewModel = viewModel
        navigationController.pushViewController(settingsViewController, animated: true)
        
        
    }
    
    
    
    
    
    
    
    
}
