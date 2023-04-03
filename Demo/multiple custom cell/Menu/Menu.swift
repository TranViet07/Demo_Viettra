//
//  Menu.swift
//  Demo
//
//  Created by TRANVIET on 22/11/2022.
//

import UIKit

class Menu: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let item = ["Facebook", "Instagram", "Youtube", "Shopee", "Bank", "Bookmark", "Interrogation", "More"]
    
    private lazy var navigateApp: String = ""
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var whiteRect: UIImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        configureUI()
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath as IndexPath) as! MenuCollectionViewCell
        cell.itemImage.image = UIImage(named: item[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.itemImage.tintColor = UIColor(named: "darkBlue")
        cell.itemLabel.text = item[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            navigateApp = item[indexPath.row]
            UIApplication.shared.open(URL(string: "http://\(navigateApp).com/")!)
            
        }
        
    }
    
    func currentTime() -> String {
         let today = Date()
         let hours = (Calendar.current.component(.hour, from: today))
         if (hours >= 0 && hours <= 11) {
             return "morning"
         } else if (hours >= 12 && hours <= 18) {
             return "afternoon"
         } else {
             return "evening"
         }
    }

}
