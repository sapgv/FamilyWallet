//
//  SettingsViewController.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 17/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var viewModel: SettingsViewModel!
    private var saveButton: UIBarButtonItem!
   
    override func viewDidLoad() {
        
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        saveButton = UIBarButtonItem(title: "Save".localized, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupTableView() {
        
        
        
    }
    
    
    
}

