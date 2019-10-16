//
//  User.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Realm
import RealmSwift

class User: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
