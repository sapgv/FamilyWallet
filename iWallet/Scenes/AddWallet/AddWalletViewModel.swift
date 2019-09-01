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

class AddWalletViewModel {
    
    var name: BehaviorRelay<String>
    var currency: Currency
    var currencies: [Currency] = Currency.currencies
    
    struct Input {
        let walletName: Driver<String>
        let currency: Driver<String>
    }
    
    struct Output {
        let saveEnabled: Driver<Bool>
    }
    
    init(name: BehaviorRelay<String> = BehaviorRelay<String>(value: ""), currency: Currency = Currency.standart) {
        self.name = name
        self.currency = currency
    }
    
    func save() {
        let realm = try! Realm()
        
//        let wallet = Wallet(name: name, currency: currency)
//        try! realm.write {
//            realm.add(wallet)
//        }
        
    }
    
    func transform(input: Input) -> Output {

        let saveEnabled: Driver<Bool> = Driver.combineLatest(input.walletName, input.currency) { name, currency in
            return !name.isEmpty && !currency.isEmpty
        }.startWith(false)
        
//        let saveEnabled: Driver<Bool> = input.walletName.map { name in
//            return !name.isEmpty
//        }.startWith(false)
    
        
//        let saveEnabled: Driver<Bool> = name.asDriver().map { !$0.isEmpty }
        return Output(saveEnabled: saveEnabled)
        
    }
    
    
    
}

