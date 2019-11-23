//
//  ColorStackView.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

enum ColorButtonAnimation: String {
    case expandBorder, shrinkBorder
}

class ColorStackView: UIStackView {
    private var selected = 0
    
    // MARK: - Custom UIs
    var redButton: ColorButton = {
        var button = ColorButton(frame: .zero)
        button.tag = 0
        button.backgroundColor = .red
        return button
    }()
    var blueButton: ColorButton = {
        var button = ColorButton(frame: .zero)
        button.tag = 1
        button.backgroundColor = .blue
        return button
    }()
    var greenButton: ColorButton = {
        var button = ColorButton(frame: .zero)
        button.tag = 2
        button.backgroundColor = .green
        return button
    }()
    var blackButton: ColorButton = {
        var button = ColorButton(frame: .zero)
        button.tag = 3
        button.backgroundColor = .black
        return button
    }()
    var whiteButton: ColorButton = {
        var button = ColorButton(frame: .zero)
        button.tag = 4
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 20
        distribution = .fillEqually
        addArrangedSubview(redButton)
        addArrangedSubview(blueButton)
        addArrangedSubview(greenButton)
        addArrangedSubview(blackButton)
        addArrangedSubview(whiteButton)
        
        redButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        blackButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        whiteButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func colorButtonTapped(_ sender: ColorButton) {
        if !sender.isSelected {
            addColor(layer: sender.layer)
            sender.isSelected = true
            selected += 1
        } else {
            if selected <= 1 {
                return
            }
            removeColor(layer: sender.layer)
            sender.isSelected = false
            selected -= 1
        }
    }
    
    private func removeColor(layer: CALayer) {
        let expandBorderAnimation = CABasicAnimation(keyPath: "borderWidth")
        expandBorderAnimation.fromValue = 5
        expandBorderAnimation.toValue = 0
        expandBorderAnimation.duration = 0.3
        expandBorderAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        expandBorderAnimation.setValue(layer, forKey: ColorButtonAnimation.shrinkBorder.rawValue)
        layer.add(expandBorderAnimation, forKey: nil)
    }
    
    private func addColor(layer: CALayer) {
        let expandBorderAnimation = CABasicAnimation(keyPath: "lineWidth")
        expandBorderAnimation.fromValue = 0
        expandBorderAnimation.toValue = 5
        expandBorderAnimation.duration = 0.3
        expandBorderAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        expandBorderAnimation.setValue(layer, forKey: ColorButtonAnimation.expandBorder.rawValue)
        layer.add(expandBorderAnimation, forKey: nil)
    }
    
    func preselected(selectedColor: [Int]) {
        guard let buttonViews = arrangedSubviews as? [ColorButton] else {
            return
        }
        
        for index in selectedColor {
            buttonViews[index].isSelected = true
            addColor(layer: buttonViews[index].layer)
        }
    }
}
