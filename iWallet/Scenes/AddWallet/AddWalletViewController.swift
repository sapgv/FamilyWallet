//
//  AddWalletViewController.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AddWalletViewController: UITableViewController {
    
    var viewModel: AddWalletViewModel!
    private var disposeBag: DisposeBag = DisposeBag()
    private var cancelButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    lazy private var dataSource: RxTableViewSectionedAnimatedDataSource<TableSection> = RxTableViewSectionedAnimatedDataSource<TableSection>(configureCell: { [walletName, currencyName, disposeBag] (ds, tv, ip, row) in
        
        let cell = tv.deque(row: row, indexPath: ip)
        (cell as? CellSetupable)?.setup(row: row)
        
        switch row.name {
            
        case "Name":
            (cell as? EditCell)?.textField.becomeFirstResponder()
            row.value.bind(to: walletName).disposed(by: disposeBag)
//            row.value.asDriver().drive(walletSubject).disposed(by: disposeBag)
        case "Currency":
            row.value.bind(to: currencyName).disposed(by: disposeBag)
//            row.value.asDriver().drive(currencySubject).disposed(by: disposeBag)
        default:
            break
        }
        
        return cell
        
        
    }, titleForHeaderInSection: { ds, section in
        return ds.sectionModels[section].headerDescription.localized
    })
    
    var walletName: PublishSubject<String> = PublishSubject<String>()
    var currencyName: PublishSubject<String> = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardHide()
        setupNavigationBar()
        setupTableView()
        bindUI()
        
    }
    
    private func setupNavigationBar() {
        cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = cancelButton
        
        saveButton = UIBarButtonItem(title: "Save".localized, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.register(cellType: .Edit)
        tableView.register(cellType: .Picked)
    }
    
    private func bindUI() {

        let cancelTrigger = cancelButton.rx.tap.asDriver()
        let saveTrigger = saveButton.rx.tap.asDriver()
        
        let input = AddWalletViewModel.Input(walletName: walletName, currencyName: currencyName, cancelTrigger: cancelTrigger, saveTrigger: saveTrigger)
        
        let output = viewModel.transform(input: input)
        
        output.dismiss
            .drive()
            .disposed(by: disposeBag)
        
        output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.saveEnabled.drive(saveButton.rx.isEnabled).disposed(by: disposeBag)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.sectionModels[indexPath.section].rows[indexPath.row].height
    }

}

