//
//  TitleCollectionCell.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 11/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class TitleCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension TitleCollectionCell: CollectionCellSetupable {
    
    func setup(item: CollectionItem) {
        self.titleLabel.text = item.title
    }
}
