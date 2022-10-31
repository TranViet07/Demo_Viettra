//
//  HomeTableView.swift
//  Demo
//
//  Created by TRANVIET on 25/10/2022.
//

import UIKit

class HomeTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
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



