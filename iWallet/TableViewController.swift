//
//  TableViewController.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 01/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import RxDataSources

class TableViewControllerBuilder<T: TableViewController> {
    
    private var viewController: T
    
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func sections(_ sections: [TableSection]) -> Self {
        viewController.sections = sections
        return self
    }
    
}

protocol TableViewController {
    
    var sections: [TableSection] { get set }
    
}
