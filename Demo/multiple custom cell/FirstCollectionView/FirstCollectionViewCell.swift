//
//  FirstCollectionViewCell.swift
//  Demo
//
//  Created by TRANVIET on 25/10/2022.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var firstCollectionViewImage: UIImageView!
    @IBOutlet weak var firstCollectionViewLabel: UILabel!
    @IBOutlet weak var firstCollectionViewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        firstCollectionViewImage.image = nil
    }
    
    
}
    
