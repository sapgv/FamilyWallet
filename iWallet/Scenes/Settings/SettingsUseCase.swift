//
//  SettingsUseCase.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 18/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxSwift


final class SettingsUseCase {
    
    func sections() -> Observable<[TableSection]> {
        
        return Observable.of([
        
            TableSection(name: "Currency", headerDescription: "Currency", rows: [
                RowBuilder.init(EditRow.self)
                    .setName("Currency")
                    .setTitle("Currency")
                    .setPlaceholder("Currency")
                    .setHeight(64)
                    .build()
            
            ])
        
        
        
        
        ])
        
        
        
    }
    
    
    
    
}
