//
//  CollectionView2.swift
//  Demo
//
//  Created by TRANVIET on 22/11/2022.
//

import UIKit

class CollectionView2: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: [Feed] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SecondCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configView(dataSource: [Feed]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
}


extension CollectionView2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        cell.secondCollectionViewCellImg.loadImage(urlString: dataSource[indexPath.row].image)
        
        return cell
    }
    
    
}
