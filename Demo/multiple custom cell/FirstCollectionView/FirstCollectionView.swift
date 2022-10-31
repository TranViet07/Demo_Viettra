//
//  FirstCollectionView.swift
//  Demo
//
//  Created by TRANVIET on 21/10/2022.
//

import UIKit

class FirstCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override var contentSize: CGSize {
            didSet {
                self.invalidateIntrinsicContentSize()
            }
        }
    override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }
}
