//
//  MenuTableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 25/10/2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var whiteRect: UIImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        menuCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func LogoutPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "Login")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
         
     }
    
    private func configureUI() {
        self.backgroundColor = .red
        menuLabel.backgroundColor = .green
    }
}

