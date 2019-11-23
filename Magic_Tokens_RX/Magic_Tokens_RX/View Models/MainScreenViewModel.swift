//
//  MainScreenViewModel.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/31/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import RxSwift

class MainScreenViewModel {
    let colors: [UIColor] = [.gray, .red, .yellow]
    private let networkManager: NetworkManager = NetworkManager()
    
    func setList() {
        networkManager.getAllSets { (result) in
            switch result {
            case .success(let model):
                print(model.data.count)
            
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
            }
        }
    }
}
