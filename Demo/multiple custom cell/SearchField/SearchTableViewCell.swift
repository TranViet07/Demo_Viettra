//
//  SearchTableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 28/10/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
