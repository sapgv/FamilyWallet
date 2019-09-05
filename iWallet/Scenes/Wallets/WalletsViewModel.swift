//
//  WalletsViewModel.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 04/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxCocoa

class WalletsViewModel: ViewModelType {
    
    var navigator: WalletsNavigator
    
    init(navigator: WalletsNavigator) {
        self.navigator = navigator
    }
    
    struct Input {
        let createWalletTrigger: Driver<Void>
    }
    
    struct Output {
        let createWallet: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let createWallet = input.createWalletTrigger
            .do(onNext: { _ in
                self.navigator.createWallet()
            })
        
        return Output(createWallet: createWallet)
    }
    
    
    
    
}
