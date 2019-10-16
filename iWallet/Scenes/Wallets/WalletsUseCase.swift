//
//  WalletsUseCase.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift
import RxRealm

class WalletsUseCase {
    
    private var realm: Realm = try! Realm()
    
    func wallets() -> [Wallet] {
        let wallets = realm.objects(Wallet.self)
        return wallets.toArray()
    }
    
    func sections() -> Observable<[CollectionSection]> {
        
        let items = wallets().map {
            CollectionItemBuilder(CollectionItem.self)
                .set(title: $0.name)
                .set(object: $0)
                .build()
        }
        
        let section = CollectionSection(name: "Wallets", items: items)
        return Observable.of([section])
        
    }
    
}
