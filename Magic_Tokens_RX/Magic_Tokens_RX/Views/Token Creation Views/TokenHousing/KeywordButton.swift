//
//  KeywordButton.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/11/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class KeywordButton: UIButton {

    private let keywordsLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap To Add Keywords"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 10
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        setupKeywordLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupKeywordLabel() {
        addSubview(keywordsLabel)
        
        NSLayoutConstraint.activate([
            keywordsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            keywordsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            keywordsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            keywordsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
    }
}
