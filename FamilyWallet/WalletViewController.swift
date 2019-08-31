//
//  WalletViewController.swift
//  FamilyWallet
//
//  Created by Grigoriy Sapogov on 26/08/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var operations: [OperationType] = OperationType.operations
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
    }
    
    func setupTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    

}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = operations[indexPath.row].rawValue
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    
    
}
