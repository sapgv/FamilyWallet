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

extension AddWalletViewController {
    
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<Section> {
        return RxTableViewSectionedAnimatedDataSource<Section>(configureCell: { (ds, tv, ip, row)  in

            let cell = tv.deque(row: row, indexPath: ip)
            (cell as? CellSetupable)?.setup(row: row)
            return cell

        })
    }
    
    
}

class SaveButton: UIBarButtonItem {
    
}

class AddWalletViewController: UITableViewController, TableViewController {
    
    var viewModel: AddWalletViewModel!
    var sections: [Section] = []
    private var disposeBag: DisposeBag = DisposeBag()
    private var saveButton: UIBarButtonItem!
    
    func sections(_ sections: [Section]) {
        self.sections = sections
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = saveButton
        
        registerKeyboardHide()
        setupTableView()
        bindUI()
        
    }
    
    private func setupNavigationBar() {
        saveButton = SaveButton(title: "Save", style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTableView() {
        tableView.register(cellType: .Edit)
    }
    
    private func bindUI() {

        let saveTrigger = saveButton.rx.tap.asDriver()
        
        let input = AddWalletViewModel.Input(saveTrigger: saveTrigger)
        
        let output = viewModel.transform(input: input)
        
        output.dismiss
            .drive()
            .disposed(by: disposeBag)
        
        
//        output.text.asObservable().subscribe(onNext: { (text) in
//            print(text)
//        })
        
//        let dataSource = AddWalletViewController.dataSource()
//
//        let saveDr = navigationItem.rightBarButtonItem!.rx.tap.asDriver()
//
//        let input = AddWalletViewModel.Input(saveTrigger: saveDr)
//        viewModel.transform(input: input)
//
////        let rows = sections.flatMap{ $0.rows }
////        let walletDriver: Driver<String> = rows.first { $0.name == "Name" }!.value.asDriver()
////        let currencyDriver: Driver<String> = rows.first { $0.name == "Currency" }!.value.asDriver()
////        let saveDriver: Driver<Void> = saveButton.rx.tap.asDriver()
////
////        let input = AddWalletViewModel.Input(walletName: walletDriver, currency: currencyDriver, saveDriver: saveDriver)
////        let output = viewModel.transform(input: input)
////
////        output.saveEnabled.drive(saveButton.rx.isEnabled).disposed(by: disposeBag)
//
//        Observable.just(sections)
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].rows[indexPath.row].height
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerDescription
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerDescription
    }
    
}

