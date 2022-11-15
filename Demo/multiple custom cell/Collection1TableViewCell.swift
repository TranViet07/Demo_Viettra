//
//  Collection1TableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 28/10/2022.
//

import UIKit

class Collection1TableViewCell: UITableViewCell, CanAutoScrollToLeft {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: [Feed] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configView(dataSource: [Feed]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func autoScrollToLeft() {
        self.collectionView.contentOffset.x = CGFloat(28)
    }
}

extension Collection1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath as IndexPath) as! FirstCollectionViewCell
        
        cell.firstCollectionViewImage.loadImage(urlString: dataSource[indexPath.row].image)
        cell.firstCollectionViewLabel.text = dataSource[indexPath.row].description
        cell.firstCollectionViewContainer.layer.cornerRadius = 5
        cell.firstCollectionViewContainer.backgroundColor = .lightGray
        cell.firstCollectionViewContainer.clipsToBounds = true
        return cell
    }
    
}
