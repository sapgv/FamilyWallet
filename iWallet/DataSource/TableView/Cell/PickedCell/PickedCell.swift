//
//  PickedCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 16/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxSwift

class PickedCell: UITableViewCell, CellSetupable {

    @IBOutlet weak var textField: UITextField!
    private var disposedBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(row: Row) {
        textField.text = row.value.value
        textField.placeholder = row.placeholder
        textField.tintColor = .clear
        let picker = PickerView(elements: row.pickerList, control: textField)
        picker.doneClosure = { [unowned self] picked in
            self.textField.text = picked?.name ?? row.pickerList.first?.name
            self.textField.rx.text.orEmpty.bind(to: row.value).disposed(by: self.disposedBag)
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
        textField.textAlignment = .right
    }
}
