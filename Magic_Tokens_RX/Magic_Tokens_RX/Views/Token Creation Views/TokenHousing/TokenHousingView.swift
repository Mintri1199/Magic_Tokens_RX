//
//  TokenHousingView.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TokenHousingView: UIView {

    // MARK: - UIs
    private var gradientLayer = CAGradientLayer()
    let textField = CreatureTypeTextField()
    private let keywordButton = KeywordButton(frame: .zero)
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        layer.cornerRadius = 25
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(keywordButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            textField.topAnchor.constraint(equalTo: stackView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            keywordButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            keywordButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            keywordButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    func setGradients(colors: [CGColor]) {
        if colors.count <= 1 {
            if gradientLayer.superlayer != nil {
                gradientLayer.removeFromSuperlayer()
            }
        
            backgroundColor = colors.isEmpty ? UIColor.lightGray : UIColor(cgColor: colors[0])
        } else if colors.count == 2 {
            gradientLayer.colors = colors
            gradientLayer.cornerRadius = self.layer.cornerRadius
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [0.0, 0.0]
            animation.toValue = [0.0, 1.0]
            animation.duration = 0.3
            layer.insertSublayer(gradientLayer, at: 0)
            gradientLayer.add(animation, forKey: nil)
        } else {
            // Set the color to gold
            gradientLayer.removeFromSuperlayer()
            backgroundColor = .systemYellow
        }
    }
}
