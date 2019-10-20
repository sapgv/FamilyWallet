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
import RxDataSources

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

class WalletsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var viewModel: WalletsViewModel!
    private var createWalletButton: UIBarButtonItem!
    private let headerId = "HeaderView"
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<CollectionSection> = RxCollectionViewSectionedAnimatedDataSource<CollectionSection>(configureCell: { (ds, cv, ip, item) in
        
        let cell = cv.deque(item: item, indexPath: ip)
        (cell as? CollectionCellSetupable)?.setup(item: item)
        cell.layer.cornerRadius = 5
        return cell
        
    },configureSupplementaryView: { (ds, cv, title, ip) in
        let headerView = cv.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: ip) as! HeaderView
        headerView.nameLabel.text = "Wallets".localized
        headerView.layer.cornerRadius = 5
              return headerView
    }
    )
    
    class func instance() -> WalletsCollectionViewController {
        let layout = VerticalLayout()
        let controller = WalletsCollectionViewController(collectionViewLayout: layout)
        return controller
    }

    var wallets: [Wallet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        bindUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem = createWalletButton
    }
    
    private func setupCollectionView() {
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.dataSource = nil
        // Register cell classes
        collectionView.register(type: .TitleCollectionCell)
        collectionView!.register(UINib(nibName: headerId, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.backgroundColor = .systemTeal
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)

    }
    
    private func setupNavigationBar() {
        createWalletButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
    }
    
    private func bindUI() {
        
        let viewWillAppear = rx.sentMessage(#selector(Self.viewWillAppear(_:))).asDriverOnErrorJustComplete().mapToVoid()
        let pull = collectionView.refreshControl!.rx.controlEvent(.valueChanged).asDriverOnErrorJustComplete().mapToVoid()
        
        let refreshTrigger = Driver.merge(viewWillAppear, pull)
        
        let input = WalletsViewModel.Input(refreshTrigger: refreshTrigger, createWalletTrigger: createWalletButton.rx.tap.asDriver(), selectWalletTrigger: collectionView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.fetching
            .drive(collectionView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.createWallet
            .drive()
            .disposed(by: disposeBag)
        
        output.walletsSections
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.selected
            .drive()
            .disposed(by: disposeBag)
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width
        return CGSize(width: w - 16, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let w = UIScreen.main.bounds.width
        return CGSize(width: w - 16, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
}
