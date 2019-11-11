//
//  CreatureTypeTextField.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

// Todo: Implement in_line autocomplete feauture with all the creature types

class CreatureTypeTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        autocorrectionType = .no
        font = UIFont(name: "Helvetica", size: 40)
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 30)!
        ]
        attributedPlaceholder = NSAttributedString(string: "Enter Creature Type", attributes:attributes)
        minimumFontSize = 14
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        backgroundColor = .black
        textColor = .white
        keyboardType = .alphabet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
