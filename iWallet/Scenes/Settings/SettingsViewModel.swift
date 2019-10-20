//
//  Setings.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 17/10/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import RxCocoa

final class SettingsViewModel {
    
    var navigator: SettingsNavigator!
    var settingsUseCase: SettingsUseCase!
    
    init(navigator: SettingsNavigator, settingsUseCase: SettingsUseCase) {
        self.navigator = navigator
        self.settingsUseCase = settingsUseCase
    }
    
    struct Input {
        
    }
    
    struct Output {
        let sections: Driver<[TableSection]>
    }
    
    func transform(input: Input) -> Output {
        
        
        let sections = settingsUseCase
                .sections()
                .asDriverOnErrorJustComplete()
        
        return Output(sections: sections)

    }
    
    
}

