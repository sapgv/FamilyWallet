//
//  AddWalletViewModel.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 01/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class AddWalletViewModel {

    private let navigator: AddWalletNavigator
    private var addWalletUseCase: AddWalletUseCase
    
    struct Input {
        let walletName: PublishSubject<String>
        let currencyName: PublishSubject<String>
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
    }

    struct Output {
        let dismiss: Driver<Void>
        let sections: Driver<[TableSection]>
        let saveEnabled: Driver<Bool>
    }
    
    init(navigator: AddWalletNavigator, addWalletUseCase: AddWalletUseCase) {
        self.navigator = navigator
        self.addWalletUseCase = addWalletUseCase
    }
    
    func transform(input: Input) -> Output {
    
        let nameAndCurrency = Driver.combineLatest(input.walletName.asDriverOnErrorJustComplete(), input.currencyName.asDriverOnErrorJustComplete())
        
        let save = input.saveTrigger
            .withLatestFrom(nameAndCurrency)
            .map { nameAndCurrency in
                return Wallet(name: nameAndCurrency.0, currency: Currency(name: nameAndCurrency.1))
            }.flatMapLatest { [unowned self] (wallet: Wallet) in
                return self.addWalletUseCase.save(wallet: wallet).asDriverOnErrorJustComplete()
            }
        

        let dismiss = Driver.of(save, input.cancelTrigger)
                    .merge()
                    .do(onNext: { _ in
                        self.navigator.toWallets()
                    })
        
        let sections = addWalletUseCase
                .sections(with: Currency.standart)
                .asDriverOnErrorJustComplete()

        let saveEnabled = nameAndCurrency.map { name, currency in
            return !name.isEmpty && !currency.isEmpty
        }
        
        return Output(dismiss: dismiss, sections: sections, saveEnabled: saveEnabled)
        
    }
    
    
    
    
    
}

