//
//  Collection2TableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 28/10/2022.
//

import UIKit

class Collection2TableViewCell: UITableViewCell {

    @IBOutlet weak var collection2: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection2.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SecondCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
