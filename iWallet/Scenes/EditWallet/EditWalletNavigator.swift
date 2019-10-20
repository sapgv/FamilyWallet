//
//  EditWalletNavigator.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 18/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol EditWalletNavigator {
    func toWallets()
}

final class DefaultEditWalletNavigator: EditWalletNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toWallets() {
        navigationController.popViewController(animated: true)
    }
    
}
