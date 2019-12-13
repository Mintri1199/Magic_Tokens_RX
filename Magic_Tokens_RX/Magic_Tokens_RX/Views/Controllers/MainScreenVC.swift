//
//  ViewController.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/21/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainScreenVC: UIViewController {
    
    // MARK: - UIs
    private let collectionView = MainScreenCV(frame: .zero, collectionViewLayout: MainScreenCVLayout())
    
    var coordinator: MainCoordinator?
    private let viewModel = MainScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupNavBar()
        formatJSON()
    }
}

// MARK: - Setup UI functions
extension MainScreenVC {
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
}

// MARK: - OBJC functions
extension MainScreenVC {
    @objc private func addButtonTapped() {
        coordinator?.createToken()
    }
}
