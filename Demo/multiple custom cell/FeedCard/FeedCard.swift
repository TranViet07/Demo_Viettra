//
//  FeedCard.swift
//  Demo
//
//  Created by TRANVIET on 22/11/2022.
//

import UIKit

class FeedCard: UICollectionViewCell {
    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedLabel: UILabel!
    
    @IBOutlet weak var imgLblView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
