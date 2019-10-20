//
//  EditWalletViewModel.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 18/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EditWalletViewModel {
    
    private var wallet: Wallet
    private var useCase: EditWalletUseCase
    private var navigator: EditWalletNavigator
    
    init(wallet: Wallet, useCase: EditWalletUseCase, navigator: EditWalletNavigator) {
        self.wallet = wallet
        self.useCase = useCase
        self.navigator = navigator
    }
    
    
    struct Input {
        let walletName: PublishSubject<String>
        let currencyName: PublishSubject<String>
//        let cancelTrigger: Driver<Void>
//        let saveTrigger: Driver<Void>
//        let deleteTrigger: Driver<Void>
    }
    
    struct Output {
        let sections: Driver<[TableSection]>
//        let dismiss: Driver<Void>
//        let saveEnabled: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let nameAndCurrency = Driver.combineLatest(input.walletName.asDriverOnErrorJustComplete(), input.currencyName.asDriverOnErrorJustComplete()).startWith((self.wallet.name, self.wallet.currency?.name ?? ""))
        
        let sections = nameAndCurrency.flatMapLatest { nameAndCurrency in
            
            return Observable.of([
                TableSection(name: "Name", headerDescription: "Name", rows: [
                    RowBuilder(EditRow.self)
                        .setName("Name")
                        .setTitle("Name")
                        .setPlaceholder("Name")
                        .setValue(nameAndCurrency.0)
                        .setHeight(64)
                        .build(),
                ]),
                TableSection(name: "Currency", headerDescription: "Currency", rows: [
                    RowBuilder(PikedRow.self)
                        .setName("Currency")
                        .setPlaceholder("Currency")
                        .setValue(nameAndCurrency.1)
                        .pickerList(Currency.currencies)
                        .setHeight(64)
                        .build()
                    ])
                ]).asDriverOnErrorJustComplete()
        }
        
        
//        let dismiss = Driver.of(input.cancelTrigger)
//            .merge()
//            .do(onNext: { _ in
//                self.navigator.toWallets()
//            })
        
        let output = Output(sections: sections)
        
        return output
    }
    
    
    
}
