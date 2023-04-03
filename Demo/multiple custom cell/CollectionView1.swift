//
//  CollectionView1.swift
//  Demo
//
//  Created by TRANVIET on 22/11/2022.
//

import UIKit

class CollectionView1: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: FirstCollectionView!
    
    private var dataSource: [Feed] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configView(dataSource: [Feed]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
}

extension CollectionView1: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath as IndexPath) as! FirstCollectionViewCell
        
//        cell.firstCollectionViewImage.loadImage(urlString: dataSource[indexPath.row].image)
//        cell.firstCollectionViewLabel.text = dataSource[indexPath.row].description
//        cell.firstCollectionViewContainer.layer.cornerRadius = 5
//        cell.firstCollectionViewContainer.backgroundColor = .lightGray
//        cell.firstCollectionViewContainer.clipsToBounds = true
        return cell
    }
    
}
