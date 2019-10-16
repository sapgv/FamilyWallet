//
//  CollectionItem.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources


class CollectionItem {
    
    var id: String = String.uuid
    var name: String = ""
    var title: String = ""
    var type: CollectionItemType {
        return .TitleCollectionCell
    }
    var object: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
    
    required init() {
        
    }
}
