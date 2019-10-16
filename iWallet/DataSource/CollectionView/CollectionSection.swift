//
//  CollectionSection.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct CollectionSection {
    
    var name: String
    var headerDescription: String
    var footerDescription: String
    var items: [CollectionItem]
    
    
    init(name: String = String.uuid, headerDescription: String = "", footerDescription: String = "", items: [CollectionItem]) {
        self.name = name
        self.headerDescription = headerDescription
        self.footerDescription = footerDescription
        self.items = items
    }
    
}

extension CollectionSection: AnimatableSectionModelType {
    
    typealias Identity = String
    typealias Item = CollectionItem
    
    var identity: String {
        return name
    }
    
    init(original: CollectionSection, items: [CollectionItem]) {
        self = original
        self.items = items
    }
    
}

extension CollectionItem: IdentifiableType, Equatable {
   
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: CollectionItem, rhs: CollectionItem) -> Bool {
        lhs.id == rhs.id
    }
    
}
