//
//  MenuCollectionView.swift
//  Demo
//
//  Created by TRANVIET on 21/10/2022.
//

import UIKit

class MenuCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }

}
