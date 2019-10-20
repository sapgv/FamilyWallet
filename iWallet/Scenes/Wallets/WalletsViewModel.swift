//
//  WalletsViewModel.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 04/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class WalletsViewModel: ViewModelType {
    
    private var navigator: WalletsNavigator
    private var walletsUseCase: WalletsUseCase
    
    init(navigator: WalletsNavigator, walletsUseCase: WalletsUseCase) {
        self.navigator = navigator
        self.walletsUseCase = walletsUseCase
    }
    
    struct Input {
        let refreshTrigger: Driver<Void>
        let createWalletTrigger: Driver<Void>
        let selectWalletTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let createWallet: Driver<Void>
        let walletsSections: Driver<[CollectionSection]>
        let selected: Driver<Wallet>
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let wallets = Driver.of(walletsUseCase.wallets())
        
        let walletsSections = input.refreshTrigger.flatMapLatest {
            return self.walletsUseCase.sections()
                .trackActivity(activityIndicator)
                .asDriver(onErrorJustReturn: [])
        }
        
        let createWallet = input.createWalletTrigger
            .do(onNext: { _ in
                self.navigator.createWallet()
            })

        let selected = input.selectWalletTrigger.withLatestFrom(wallets) { ip, wallets -> Wallet in
            return wallets[ip.row]
        }.do(onNext: { wallet in
            self.navigator.toEditWallet(wallet: wallet)
        })
        
        let fetching = activityIndicator.asDriver()
        
        return Output(fetching: fetching, createWallet: createWallet, walletsSections: walletsSections, selected: selected)
        
    }
    
    
    
    
}
