//
//  AddWalletViewController.swift
//  FamilyWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class Section {
    
    var name: String = String.uuid
    var headerDescription: String = ""
    var footerDescription: String = ""
    var rows: [Row] = []
    
    init(name: String = String.uuid, headerDescription: String = "", footerDescription: String = "", rows: [Row]) {
        self.name = name
        self.headerDescription = headerDescription
        self.footerDescription = footerDescription
        self.rows = rows
    }
    
}



enum CellType: String {
    case Default = "Default"
    case Title = "Title"
    case Subtitle = "Subtitle"
    case Edit = "EditCell"
    case TitleEdit = "TitleEditCell"
    case Button = "ButtonCell"
    case RightDetail = "RightDetailCell"
}

protocol TableView {
    func identifier(row: Row) -> String
    func register(cellType: CellType, identifier: String)
    func register(cellType: UITableViewCell.Type, identifier: String)
    func deque(row: Row, indexPath: IndexPath) -> UITableViewCell
}

extension UITableView: TableView {
    
    func identifier(row: Row) -> String {
        return row.cellType.rawValue
    }
    
    func register(cellType: CellType, identifier: String = "") {
        self.register(UINib(nibName: cellType.rawValue, bundle: nil), forCellReuseIdentifier: identifier.isEmpty ? cellType.rawValue : identifier)
    }
    
    func register(cellType: UITableViewCell.Type, identifier: String) {
        self.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func deque(row: Row, indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: identifier(row: row), for: indexPath)
    }
    
}

class AddWalletViewController: UITableViewController {
    
    var name: String = ""
    var currency: Currency?
    private var currencies: [Currency] = Currency.currencies
    private var sections: [Section] = []
    
    func sections(_ sections: [Section]) {
        self.sections = sections
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardHide()
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.register(cellType: .Edit)
        tableView.register(cellType: .TitleEdit)
        tableView.register(cellType: .Button)

    }
    
    @objc func save(sender: AnyObject) {
        
        print("save")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = sections[indexPath.section].rows[indexPath.row]
        row.select?(tableView, indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let row = sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.deque(row: row, indexPath: indexPath)
        (cell as? CellSetupable)?.setup(row: row)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleEditCell", for: indexPath) as! TitleEditCell
//        if indexPath.section == 0 {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as! EditCell
//            cell.setupCell()
//            return cell
//        }
//        
//        if indexPath.section == 2 {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleEditCell", for: indexPath) as! TitleEditCell
//            
//            let pv = PickerView(elements: currencies, viewController: self)
//            pv.doneClosure = { element in
//                cell.textField.text = element?.name
//            }
//            cell.textField.inputView = pv
//            cell.textField.inputAccessoryView = pv.toolbar
//            cell.textField.borderStyle = .none
//            cell.textField.textAlignment = .right
//            cell.textField.text = currencies.first?.name
//            cell.textField.delegate = self
//            
//            return cell
//        }
        
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(section)"
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].rows[indexPath.row].height
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerDescription
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerDescription
    }
    
}


extension AddWalletViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}



class TextField: UITextField, UITextFieldDelegate {
    
    var allowEditing = false
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return allowEditing
    }
    
    init() {
        
        
        super.init(frame: CGRect.zero)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
}
