//
//  ViewModelType.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 04/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
