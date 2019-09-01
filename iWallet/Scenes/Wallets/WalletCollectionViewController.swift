//
//  WalletCollectionViewController.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 02/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "Cell"

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {

    }
    
}

class VerticalLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class WalletCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let headerId = "HeaderView"
    let disposedBag: DisposeBag = DisposeBag()
    
    class func instance() -> WalletCollectionViewController {
        let layout = VerticalLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let controller = WalletCollectionViewController(collectionViewLayout: layout)
        return controller
    }

    var wallets: [Wallet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView!.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView!.register(UINib(nibName: headerId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .red
        
        let addWalletButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
//        navigationController?.navigationItem.rightBarButtonItem = addWalletButton
        navigationItem.rightBarButtonItem = addWalletButton
    }

    @objc func add(sender: Any) {
        
        print("add")
//        let addWalletViewController = AddWalletViewController.loadFromNib()
        let addWalletViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddWalletViewController") as! AddWalletViewController
//        let addWalletViewController = AddWalletViewController(style: .grouped)
        let addWalletViewModel = AddWalletViewModel()
        
        addWalletViewController.viewModel = addWalletViewModel
        addWalletViewController.sections([
            
            Section(rows: [
                RowBuilder<EditRow>()
                    .setName("Name")
                    .setTitle("Name")
                    .setPlaceholder("Name")
                    .setHeight(64)
                    .build(),
                RowBuilder<EditRow>()
                    .setName("Currency")
                    .setPlaceholder("Currency")
                    .pickerList(Currency.currencies)
                    .setHeight(64)
                    .build()
                
                ])
            
            
//            Section(rows: [
//                RowBuilder<EditRow>()
//                    .setPlaceholder("Name")
//                    .setHeight(64)
//                    .bind { row in
//
//                        row.value.bind(onNext: { text in
//                            addWalletViewModel.name = text
//                        }).disposed(by: disposedBag)
//
//                    }
//                    .build(),
//                RowBuilder<EditRow>()
//                    .setPlaceholder("Currency")
//                    .pickerList(Currency.currencies)
//                    .setHeight(64)
//                    .bind { row in
//
//                        row.pickedElement.bind(onNext: { picked in
//                            addWalletViewModel.currency = Currency(name: picked.name)
//                        }).disposed(by: disposedBag)
////                        Observable.just(row.pickedElement).bind(onNext: { picked in
////                            addWalletViewModel.currency = Currency(name: picked?.name ?? "")
////                        }).disposed(by: disposedBag)
//
//                    }
//                    .build()
//
//                ])
        ])
        navigationController?.pushViewController(addWalletViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return wallets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = .blue
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width
        return CGSize(width: w, height: 44)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        headerView.nameLabel.text = "wallet"
        headerView.frame.size.height = 100
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
