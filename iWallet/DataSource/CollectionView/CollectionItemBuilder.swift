//
//  CollectionItemBuilder.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class CollectionItemBuilder<T: CollectionItem> {
    
    private var item: T
    
    init(_ type: T.Type) {
        item = T.init()
    }
    
    func set(name: String) -> Self {
        item.name = name
        return self
    }
    
    func set(title: String) -> Self {
        item.title = title
        return self
    }
    
    func set(object: Any) -> Self {
        item.object.accept(object)
        return self
    }
    
    func build() -> T {
        return item
    }
}
