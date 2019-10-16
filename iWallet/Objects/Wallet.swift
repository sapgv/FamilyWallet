//
//  Wallet.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Realm
import RealmSwift

class Wallet: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var currency: Currency? = nil
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(name: String, currency: Currency) {
        self.init()
        self.name = name
        self.currency = currency
    }
    
}
