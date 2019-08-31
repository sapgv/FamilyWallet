//
//  EditCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 29/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

protocol CellSetupable {
    
    func setup(row: Row)
    
}

class EditCell: UITableViewCell, CellSetupable {

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
        textField.placeholder = row.placeholder
        if row.isPicking {
            textField.tintColor = .clear
            let picker = PickerView(elements: row.pickerList, control: textField)
            picker.doneClosure = { picked in
                self.textField.text = picked?.name
            }
           
            
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: textField.bounds.height))
            
            let im = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            im.image = UIImage(named: "collapse")
            im.center = paddingView.center
            paddingView.addSubview(im)
            
            textField.rightView = paddingView
            textField.rightViewMode = .always
            textField.inputView = picker
            textField.inputAccessoryView = picker.toolbar
            textField.text = row.pickerList.first?.name
            textField.textAlignment = .right
            textField.text = row.pickerList.first?.name
        }
    }
}