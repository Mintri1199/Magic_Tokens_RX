//
//  StatsButton.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/11/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class StatsButton: UIButton {

    var power: Int = 1 {
        didSet {
            // This might have to be in the main queue
            statsLabel.text = "\(power)/\(toughness)"
        }
    }
    var toughness: Int = 1 {
        didSet {
            statsLabel.text = "\(power)/\(toughness)"
        }
    }
    
    private let statsLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "1/1"
        label.textColor = .gray
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 40)
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.allowsDefaultTighteningForTruncation = false
        backgroundColor = .white
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(statsLabel)
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: topAnchor),
            statsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            statsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            statsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            ])
    }
}
