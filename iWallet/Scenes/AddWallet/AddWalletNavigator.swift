//
//  AddWalletNavigator.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 04/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol AddWalletNavigator {
    
    func toWallets()
    
}

final class DefaultAddWalletNavigator: AddWalletNavigator {
    
    private let navigationController: UINavigationController!
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toWallets() {
        navigationController.popViewController(animated: true)
    }
}
