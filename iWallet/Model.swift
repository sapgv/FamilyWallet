//
//  Model.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Currency: Object, PickerElement {
    
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
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

class Wallet: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var currency: Currency? = nil
    
    convenience init(name: String, currency: Currency) {
        self.init()
        self.name = name
        self.currency = currency
    }
    
}

class User: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    
}

enum OperationType: String, CaseIterable {
    case plus
    case minus
    
    static var operations: [OperationType] {
        return OperationType.allCases
    }
}

class Operation: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var wallet: Wallet?
    @objc dynamic var amount: Double = 0
    
    @objc dynamic private var privateOperationType: String = OperationType.plus.rawValue
    var opertaionType: OperationType {
        get { return OperationType(rawValue: privateOperationType)! }
        set { privateOperationType = newValue.rawValue }
    }
    
}
