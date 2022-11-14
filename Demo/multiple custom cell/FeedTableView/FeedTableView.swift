//
//  FeedTableView.swift
//  Demo
//
//  Created by TRANVIET on 21/10/2022.
//

import UIKit

class FeedTableView: UITableView {

    
    override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }
    override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
            return self.contentSize
        }
    override var contentSize: CGSize {
            didSet {
                self.invalidateIntrinsicContentSize()
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
