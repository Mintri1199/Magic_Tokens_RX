//
//  MainScreenCV.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/31/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class MainScreenCV: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
