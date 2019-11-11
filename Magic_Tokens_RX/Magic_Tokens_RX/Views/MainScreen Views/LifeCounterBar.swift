//
//  LifeCounterBar.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/31/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class LifeCounterBar: UIStackView {
    // MARK: - UIs
    // life count label
    // increment button
    // decrement button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // add set up function
    }
}
