//
//  SettingsViewController.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 17/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsViewController: UITableViewController {
    
    var viewModel: SettingsViewModel!
    private var disposeBag: DisposeBag = DisposeBag()
    private var saveButton: UIBarButtonItem!
   
    lazy private var dataSource: RxTableViewSectionedAnimatedDataSource<TableSection> = RxTableViewSectionedAnimatedDataSource<TableSection>(configureCell: { (ds, tv, ip, row) -> UITableViewCell in
        
        let cell = tv.deque(row: row, indexPath: ip)
        
        return cell
        
        
    })
    override func viewDidLoad() {
        
        setupNavigationBar()
        setupTableView()
        bindUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupNavigationBar() {
        saveButton = UIBarButtonItem(title: "Save".localized, style: .done, target: nil, action: nil)
        
    }
    
    func setupTableView() {
        
        tableView.dataSource = nil
        tableView.register(cellType: .Edit)
        tableView.tableFooterView = UIView()
    }
    
    func bindUI() {
        
        let input = SettingsViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
}

