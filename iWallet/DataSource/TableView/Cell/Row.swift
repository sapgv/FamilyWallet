//
//  Row.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 31/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RowBuilder<T: Row> {
    
    private var row: T
    
    init(_ type: T.Type) {
        row = T.init()
    }
    
    func setName(_ name: String) -> Self {
        row.name = name
        return self
    }
    
    func setTitle(_ title: String) -> Self {
        row.title = title.localized
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

    func select(onSelect: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)? = nil) -> Self {
        row.select = onSelect
        return self
    }
    
    func setValue(_ value: String) -> Self {
        row.value.accept(value)
        return self
    }
    
    func bind(_ completion: (T) -> Void) -> Self {
        completion(row)
        return self
    }
    
    func build() -> T {
        return row
    }
    
}


protocol BaseRow {
    var id: String { get set }
    var name: String { get set }
    var title: String { get set }
    var placeholder: String { get set }
    var height: CGFloat { get set }
    var isPicking: Bool { get set }
    var pickerList: [PickerElement] { get set }
    var cellType: CellType { get }
    var select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)? { get set }
    
    //Rx
    var value: BehaviorRelay<String> { get set }
    var pickedElement: ReplaySubject<PickerElement> { get set }
    
}



class Row: BaseRow {
    
    var id: String = String.uuid
    var name: String = ""
    var title: String = ""
    var placeholder: String = ""
    var height: CGFloat = 44
    var isPicking: Bool = false
    var pickerList: [PickerElement] = []
    var cellType: CellType {
        fatalError("Cell type must be implements in subclasses")
    }
    var select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var pickedElement: ReplaySubject<PickerElement> = ReplaySubject<PickerElement>.create(bufferSize: 1)
    
    required init() {}
}

class TitleRow: Row {
    
    override var cellType: CellType {
        return .Title
    }
    
    init(name: String = "", isPicking: Bool = false, pickerList: [PickerElement] = [], select: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)? = nil) {
        super.init()
        self.name = name
        self.isPicking = isPicking
        self.pickerList = pickerList
        self.select = select
    }
    
    required init() {
        fatalError("init() has not been implemented")
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
    
    init(name: String = "", isPicking: Bool = false, pickerList: [PickerElement] = []) {
        super.init()
        self.name = name
        self.isPicking = isPicking
        self.pickerList = pickerList
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override var cellType: CellType {
        return .TitleEdit
    }
    
}

class PikedRow: Row {
    
    override var cellType: CellType {
        return .Picked
    }
}

