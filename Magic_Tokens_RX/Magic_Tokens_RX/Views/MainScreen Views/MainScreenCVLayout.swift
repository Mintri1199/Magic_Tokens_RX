//
//  MainScreenCVLayout.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 10/31/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class MainScreenCVLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else {
            return
        }
        
        // This is the available width of the screen
        let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width
        
        let minColumnWidth = CGFloat(100)
        
        // Calculate how many columns to have depend on the width of the screen
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        
        // Set the cell width accordance to the number of columns there are
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        // Calculate the hypothenuse to insets correctly when the token rotate
        let hypothenuseOfItem = pow((pow(cellWidth, 2) * 2), 0.5)
        let hypothenuseInsets = (hypothenuseOfItem / 4).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.sectionInset = UIEdgeInsets(top: hypothenuseInsets, left: hypothenuseInsets, bottom: hypothenuseInsets, right: hypothenuseInsets)
        self.sectionInsetReference = .fromSafeArea
        
        self.minimumLineSpacing = hypothenuseOfItem / 3
      
        self.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}
