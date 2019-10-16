//
//  CollectionViewExtensions.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionView {
    func register(type: CollectionItemType, identifier: String)
    func identifier(item: CollectionItem) -> String
    func deque(item: CollectionItem, indexPath: IndexPath) -> UICollectionViewCell
}

enum CollectionItemType: String {
    case TitleCollectionCell = "TitleCollectionCell"
    case CollectionItem = "CollectionItem"
}


extension UICollectionView: CollectionView {
    
    func register(type: CollectionItemType, identifier: String = "") {
        self.register(UINib(nibName: type.rawValue, bundle: nil), forCellWithReuseIdentifier: identifier.isEmpty ? type.rawValue : identifier)
    }
    
    func register(type: UICollectionViewCell.Type, identifier: String) {
        self.register(type, forCellWithReuseIdentifier:  identifier)
    }
    
    func identifier(item: CollectionItem) -> String {
        return item.type.rawValue
    }
    
    func deque(item: CollectionItem, indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: identifier(item: item), for: indexPath)
    }
    
    
    
}
