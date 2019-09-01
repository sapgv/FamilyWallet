//
//  Section.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 01/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct Section {
    
    var name: String = String.uuid
    var headerDescription: String
    var footerDescription: String
    var rows: [Row]
    
    init(name: String = String.uuid, headerDescription: String = "", footerDescription: String = "", rows: [Item]) {
        self.name = name
        self.headerDescription = headerDescription
        self.footerDescription = footerDescription
        self.rows = rows
    }
    
}

extension Section: AnimatableSectionModelType {
    
    typealias Identity = String
    typealias Item = Row
    
    var identity: String {
        return name
    }
    
    var items: [Row] {
        return rows
    }
    
    init(original: Section, items: [Item]) {
        self = original
        self.rows = items
    }
    
}

extension Row: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: Row, rhs: Row) -> Bool {
        return lhs.id == rhs.id
    }
    
}
