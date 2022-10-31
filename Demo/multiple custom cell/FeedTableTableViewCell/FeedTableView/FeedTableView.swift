//
//  FeedTableView.swift
//  Demo
//
//  Created by TRANVIET on 21/10/2022.
//

import UIKit

class FeedTableView: UITableView {

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
