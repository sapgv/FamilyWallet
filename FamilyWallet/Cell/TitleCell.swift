//
//  TitleCell.swift
//  FamilyWallet
//
//  Created by Grigoriy Sapogov on 30/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    var viewController: UIViewController?
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TitleCell: CellSetupable {
    
    func setup(row: Row) {
        
        if row.isPicking && !row.pickerList.isEmpty {
            let pv = PickerView(elements: row.pickerList, viewController: viewController)
            pv.doneClosure = { element in
                self.titleLabel.text = element?.name
            }
            pv.cancelClosure = {
//                self
            }
//            textField.inputView = pv
//            textField.inputAccessoryView = pv.toolbar
//            textField.borderStyle = .none
//            textField.textAlignment = .right
//            textField.text = row.pickerList.first?.name
        }
        
    }
    
}
