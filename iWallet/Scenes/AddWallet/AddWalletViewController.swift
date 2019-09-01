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

class TableViewControllerBuilder<T: TableViewController> {
    
    private var viewController: T
    
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func sections(_ sections: [Section]) -> Self {
        viewController.sections = sections
        return self
    }
    
}

protocol TableViewController {
    
    var sections: [Section] { get set }
    
}

extension AddWalletViewController {
    
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<Section> {
        return RxTableViewSectionedAnimatedDataSource<Section>(configureCell: { (ds, tv, ip, row)  in

            let cell = tv.deque(row: row, indexPath: ip)
            (cell as? CellSetupable)?.setup(row: row)
            return cell

        })
    }
    
    
}
class AddWalletViewController: UITableViewController, TableViewController {
    
    var viewModel: AddWalletViewModel!
    var sections: [Section] = []
    private var disposeBag: DisposeBag = DisposeBag()
    
    func sections(_ sections: [Section]) {
        self.sections = sections
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        
        registerKeyboardHide()
        setupNavigationBar()
        setupTableView()
        bindUI()
        
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(title: "Save".localized, style: .done, target: self, action: #selector(save(sender:)))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTableView() {
        tableView.register(cellType: .Edit)
        tableView.register(cellType: .TitleEdit)
        tableView.register(cellType: .Button)
    }
    
    private func bindUI() {

        let dataSource = AddWalletViewController.dataSource()
        
        let rows = sections.flatMap{ $0.rows }
        let walletDriver: Driver<String> = rows.first { $0.name == "Name" }!.value.asDriver()
        let currencyDriver: Driver<String> = rows.first { $0.name == "Currency" }!.value.asDriver()

        let input = AddWalletViewModel.Input(walletName: walletDriver, currency: currencyDriver)
        let output = viewModel.transform(input: input)
        
        output.saveEnabled.drive(onNext: { [unowned self] saveEnabled in
            self.navigationItem.rightBarButtonItem?.isEnabled = saveEnabled
        }).disposed(by: disposeBag)
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    @objc func save(sender: AnyObject) {
        
        print("save")
        
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

