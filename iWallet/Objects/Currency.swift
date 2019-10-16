//
//  Currency.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Realm
import RealmSwift

class Currency: Object, PickerElement {
    
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    static var currencies: [Currency] {
        return [
            Currency(name: "RUB"),
            Currency(name: "USD"),
            ]
    }
    
    static var standart: Currency! {
        return currencies.first
    }
    
}
