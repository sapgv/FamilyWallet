//
//  TableView.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 01/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

protocol TableView {
    func identifier(row: BaseRow) -> String
    func register(cellType: CellType, identifier: String)
    func register(cellType: UITableViewCell.Type, identifier: String)
    func deque(row: BaseRow, indexPath: IndexPath) -> UITableViewCell
}

enum CellType: String {
    case Default = "Default"
    case Title = "Title"
    case Subtitle = "Subtitle"
    case Edit = "EditCell"
    case TitleEdit = "TitleEditCell"
    case Button = "ButtonCell"
    case RightDetail = "RightDetailCell"
    case Picked = "PickedCell"
}

extension UITableView: TableView {
    
    func identifier(row: BaseRow) -> String {
        return row.cellType.rawValue
    }
    
    func register(cellType: CellType, identifier: String = "") {
        self.register(UINib(nibName: cellType.rawValue, bundle: nil), forCellReuseIdentifier: identifier.isEmpty ? cellType.rawValue : identifier)
    }
    
    func register(cellType: UITableViewCell.Type, identifier: String) {
        self.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func deque(row: BaseRow, indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: identifier(row: row), for: indexPath)
    }
    
}
