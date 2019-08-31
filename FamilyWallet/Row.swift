//
//  Row.swift
//  FamilyWallet
//
//  Created by Grigoriy Sapogov on 31/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import UIKit

class RowBuilder<T: Row> {
    
    private var row: T = T.init()
    
    func setName(_ name: String) -> Self {
        row.name = name.localized
        return self
    }
    
    func setPlaceholder(_ placeholder: String) -> Self {
        row.placeholder = placeholder.localized
        return self
    }

    func setHeight(_ height: CGFloat) -> Self {
        row.height = height
        return self
    }
    
    func isPicking(_ isPicking: Bool) -> Self {
        row.isPicking = isPicking
        return self
    }
    
    func pickerList(_ pickerList: [PickerElement]) -> Self {
        row.isPicking = true
        row.pickerList = pickerList
        return self
    }

    func build() -> T {
        return row
    }
    
}


protocol BaseRow {
    var id: String { get set }
    var name: String { get set }
    var placeholder: String { get set }
    var height: CGFloat { get set }
    var isPicking: Bool { get set }
    var pickerList: [PickerElement] { get set }
    var cellType: CellType { get }
    var select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)? { get set }
}

class Row: BaseRow {
    
    var id: String = String.uuid
    var name: String = ""
    var placeholder: String = ""
    var height: CGFloat = 44
    var isPicking: Bool = false
    var pickerList: [PickerElement] = []
    var cellType: CellType {
        fatalError("Cell type must be implements in subclasses")
    }
    var select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    required init(_ name: String = String.uuid) {
        self.name = name
    }
}

class TitleRow: Row {
    
    override var cellType: CellType {
        return .Title
    }
    
    convenience init(name: String = "", isPicking: Bool = false, pickerList: [PickerElement] = [], select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)? = nil) {
        self.init(name: name)
        self.isPicking = isPicking
        self.pickerList = pickerList
        self.select = select
    }
}

class EditRow: Row {
    
    override var cellType: CellType {
        return .Edit
    }

 }

class RightDetailRow: Row {
    
    override var cellType: CellType {
        return .RightDetail
    }
    
}
class TitleEditRow: Row {
    
    convenience init(name: String = "", isPicking: Bool = false, pickerList: [PickerElement] = []) {
        self.init(name: name)
        self.isPicking = isPicking
        self.pickerList = pickerList
    }
    
    override var cellType: CellType {
        return .TitleEdit
    }
    
}

