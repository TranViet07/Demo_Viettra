//
//  ViewController.swift
//  Demo
//
//  Created by TRANVIET on 04/10/2022.	
//

import UIKit

class ViewController: UIViewController {
    
    var dataModel = DataModel()
    
    let urlString = "https://69b6b792-2919-4041-a084-4182464efd6e.mock.pstmn.io/feeds"
    

    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout()
    
        dataModel.getData(from: urlString)
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.backgroundColor = UIColor(named: "lightGreen")
        
        
        homeCollectionView.register(UINib(nibName: "Menu", bundle: nil), forCellWithReuseIdentifier: "Menu")
        homeCollectionView.register(UINib(nibName: "Search", bundle: nil), forCellWithReuseIdentifier: "Search")
        homeCollectionView.register(UINib(nibName: "CollectionView1", bundle: nil), forCellWithReuseIdentifier: "CollectionView1")
        homeCollectionView.register(UINib(nibName: "Status", bundle: nil), forCellWithReuseIdentifier: "Status")
        homeCollectionView.register(UINib(nibName: "CollectionView2", bundle: nil), forCellWithReuseIdentifier: "CollectionView2")
        homeCollectionView.register(UINib(nibName: "FeedCard", bundle: nil), forCellWithReuseIdentifier: "FeedCard")
        
        
        homeCollectionView.refreshControl = UIRefreshControl()
        homeCollectionView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        
        customRefresh()
        view.layoutIfNeeded()
    }
    private func collectionViewLayout() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize.width = screenWidth
        layout.itemSize.height = 400
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 28
//        layout.sectionInset.bottom = 28

        homeCollectionView?.collectionViewLayout = layout
    }
    
    // pull to refresh
    
    @objc func pullToRefresh() {
        DispatchQueue.main.async {
            self.homeCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    func customRefresh(){
        let target = self.homeCollectionView.refreshControl
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        target?.tintColor = .white
        target?.attributedTitle = .init(string: "Refreshing", attributes: attributes)
        
    }
    
    func scrollToTop() {
        self.homeCollectionView.contentOffset.y = .zero
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToTop()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 5 {
            return dataModel.feed.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath as IndexPath) as! Menu
            cell.menuLabel.text = "Good \(cell.currentTime())!"
            cell.menuCollectionView.backgroundColor = .none
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath as IndexPath) as! Search
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView1", for: indexPath as IndexPath) as! CollectionView1
            cell.configView(dataSource: dataModel.feed)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Status", for: indexPath as IndexPath) as! Status
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView2", for: indexPath as IndexPath) as! CollectionView2
            cell.configView(dataSource: dataModel.feed)
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCard", for: indexPath as IndexPath) as! FeedCard

            cell.feedImage.loadImage(urlString: dataModel.feed[indexPath.row].image)
            cell.feedLabel.text = dataModel.feed[indexPath.row].description
            cell.imgLblView.backgroundColor = .white
            cell.imgLblView.layer.cornerRadius = 5
            cell.imgLblView.clipsToBounds = true
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
}


    
//extension ViewController: UITableViewDelegate, UITableViewDataSource {

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 2{
//            return 156
//        }
//        tableView.estimatedRowHeight = 100
//        return UITableView.automaticDimension
//    }
//
//}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y <= 0)
    }
}

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImage(urlString: String) {
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            imageCache.setObject(image as AnyObject, forKey: urlString as AnyObject)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}




