//
//  ColorButton.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UIKit

class ColorButton: UIButton {
    // MARK: - Layers
    var pictureLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 15
        setupPictureLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layers
    private func setupPictureLayer() {
        pictureLayer.frame = frame
        pictureLayer.contentsGravity = .resizeAspectFill
        pictureLayer.cornerRadius = frame.height / 4
        layer.addSublayer(pictureLayer)
    }
}
