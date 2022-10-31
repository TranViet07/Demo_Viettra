//
//  FeedLabelTableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 28/10/2022.
//

import UIKit

class FeedLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
