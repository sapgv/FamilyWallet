//
//  ButtonCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell, CellSetupable {

    var action: (() -> Void)?

    @IBOutlet weak var button: UIButton!
    @IBAction func actionButton(_ sender: Any) {
        action?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(row: Row) {
        
        self.button.setTitleColor(.gray, for: .normal)
        self.button.contentHorizontalAlignment = .right
    }
    
}
