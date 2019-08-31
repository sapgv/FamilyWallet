//
//  TitleEditCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class TitleEditCell: UITableViewCell, CellSetupable {

    var viewController: UIViewController?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(row: Row) {
        
        titleLabel.text = row.name
        if row.isPicking && !row.pickerList.isEmpty {
            let pv = PickerView(elements: row.pickerList, viewController: viewController)
            pv.doneClosure = { element in
                self.textField.text = element?.name
                self.textField.endEditing(true)
            }
            pv.cancelClosure = {
                self.textField.endEditing(true)
            }
            textField.inputView = pv
            textField.inputAccessoryView = pv.toolbar
            textField.borderStyle = .none
            textField.textAlignment = .right
            textField.text = row.pickerList.first?.name
        }
    }
}


