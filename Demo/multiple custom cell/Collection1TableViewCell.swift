//
//  Collection1TableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 28/10/2022.
//

import UIKit

class Collection1TableViewCell: UITableViewCell {

    @IBOutlet weak var collection1: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
        
        collection1.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
