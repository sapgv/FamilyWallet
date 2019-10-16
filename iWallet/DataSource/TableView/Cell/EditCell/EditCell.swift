//
//  EditCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 29/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditCell: UITableViewCell, CellSetupable {

    @IBOutlet weak var textField: UITextField!
    var disposedBag: DisposeBag = DisposeBag()
    
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
        textField.rx.text.orEmpty.bind(to: row.value).disposed(by: disposedBag)
    }
    
}
