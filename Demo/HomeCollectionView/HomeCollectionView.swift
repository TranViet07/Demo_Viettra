//
//  HomeCollectionView.swift
//  Demo
//
//  Created by TRANVIET on 22/11/2022.
//

import UIKit

class HomeCollectionView: UICollectionView {

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
