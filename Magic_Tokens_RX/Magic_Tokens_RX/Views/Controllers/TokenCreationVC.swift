//
//  TokenCreationVC.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TokenCreationVC: UIViewController {
    
    var selectedColor: [UIColor] = []
    var coordinator: MainCoordinator?
    
    // MARK: - Custom UIs
    private let tokenHousing = TokenHousingView(frame: .zero)
    private let colorButtonStack = ColorStackView(frame: .zero)
    private let statsButton = StatsButton(frame: .zero)
    // add stat button
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupTokenHousing()
        setupStatsButton()
        setupColorStackView()
        
        print("Finish set up")
    }
}

// MARK: - Setup UIs
extension TokenCreationVC {
    private func setupTokenHousing() {
        view.addSubview(tokenHousing)
        
        NSLayoutConstraint.activate([
            tokenHousing.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tokenHousing.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tokenHousing.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tokenHousing.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)
        ])
    }
    
    private func setupStatsButton() {
        view.addSubview(statsButton)
        NSLayoutConstraint.activate([
            statsButton.topAnchor.constraint(equalTo: tokenHousing.bottomAnchor, constant: -10),
            statsButton.trailingAnchor.constraint(equalTo: tokenHousing.trailingAnchor, constant: -20),
            statsButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 15)
        ])
    }
    
    private func setupColorStackView() {
        view.addSubview(colorButtonStack)
        NSLayoutConstraint.activate([
            colorButtonStack.topAnchor.constraint(equalTo: statsButton.bottomAnchor, constant: 30),
            colorButtonStack.leadingAnchor.constraint(equalTo: tokenHousing.leadingAnchor, constant: 0),
            colorButtonStack.trailingAnchor.constraint(equalTo: tokenHousing.trailingAnchor, constant: 0)
            ])
        
        view.layoutSubviews()
        let sideInsets = view.layoutMargins.right * 2
        let buttonHeight = (tokenHousing.bounds.width - (80 + sideInsets)) / 5
        colorButtonStack.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}
