//
//  SectionBuilder.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 06/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift
import RxRealm

final class AddWalletUseCase {
    
    private var realm: Realm = try! Realm()
    
    func save(wallet: Wallet) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.save(entity: wallet)
        }
    }
    
    func sections(with currency: Currency) -> Observable<[TableSection]> {
        
        return Observable.of([
            
            TableSection(name: "Name", headerDescription: "Name", rows: [
                RowBuilder(EditRow.self)
                    .setName("Name")
                    .setTitle("Name")
                    .setPlaceholder("Name")
                    .setHeight(64)
                    .build(),
                ]),
            TableSection(name: "Currency", headerDescription: "Currency", rows: [
                RowBuilder(PikedRow.self)
                    .setName("Currency")
                    .setPlaceholder("Currency")
                    .setValue(currency.name)
                    .pickerList(Currency.currencies)
                    .setHeight(64)
                    .build()
                ])
            
            
            ])
        
    }
    
    
    
    
    
    
    
    
}
