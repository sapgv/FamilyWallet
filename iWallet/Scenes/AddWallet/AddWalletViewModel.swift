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
    
    var name: BehaviorRelay<String>
    var currency: Currency
    var currencies: [Currency] = Currency.currencies

    struct Input {
        let saveTrigger: Driver<Void>
    }

    struct Output {
        let dismiss: Driver<Void>
    }
    
    init(name: BehaviorRelay<String> = BehaviorRelay<String>(value: ""), currency: Currency = Currency.standart, navigator: AddWalletNavigator) {
        self.name = name
        self.currency = currency
        self.navigator = navigator
    }
    
    func save(wallet: Wallet) -> Observable<Void> {
        
        let obs = Observable.just(wallet).map { wallet in
            let realm = try! Realm()
            try! realm.write {
                realm.add(wallet)
            }
        }.mapToVoid()
        
        return obs
        
    }
    
    func transform(input: Input) -> Output {
    

        let save = input.saveTrigger.flatMapLatest { _ in
            Observable.of(()).asDriverOnErrorJustComplete()
        }

        let dismiss = Driver.of(save)
                    .merge()
                    .do(onNext: { _ in
                        self.navigator.toWallets()
                    })
        
        return Output(dismiss: dismiss)
        
    }
    
    
    
    
    
}

