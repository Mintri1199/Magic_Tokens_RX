//
//  MainCoordinator.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/21/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator: [Coordinator] = []
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = MainScreenVC()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
