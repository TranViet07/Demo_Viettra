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
    

    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataModel.getData(from: urlString)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorStyle = .none
        homeTableView.backgroundColor = UIColor(named: "lightGreen")
        
        homeTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        homeTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        homeTableView.register(UINib(nibName: "Collection1TableViewCell", bundle: nil), forCellReuseIdentifier: "Collection1TableViewCell")
        homeTableView.register(UINib(nibName: "FeedLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedLabelTableViewCell")
        homeTableView.register(UINib(nibName: "Collection2TableViewCell", bundle: nil), forCellReuseIdentifier: "Collection2TableViewCell")
        homeTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.estimatedRowHeight = UITableView.automaticDimension
        homeTableView.refreshControl = UIRefreshControl()
        homeTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        customRefresh()
        view.layoutIfNeeded()
    }
    
    // pull to refresh
    
    @objc func pullToRefresh() {
        DispatchQueue.main.async {
            self.homeTableView.refreshControl?.endRefreshing()
        }
    }
    
    func customRefresh(){
        let target = self.homeTableView.refreshControl
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        target?.tintColor = .white
        target?.attributedTitle = .init(string: "Refreshing", attributes: attributes)
        
    }
    
    func scrollToTop() {
        self.homeTableView.contentOffset.y = .zero
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
//        collectionView1ScrollToLeft()
//        CollectionView2ScrollToLeft()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToTop()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 6 {
            return dataModel.feed.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath as IndexPath) as! MenuTableViewCell
            cell.menuLabel.text = "Good \(cell.currentTime())!"
            cell.menuCollectionView.backgroundColor = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath as IndexPath) as! SearchTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collection1TableViewCell", for: indexPath as IndexPath) as! Collection1TableViewCell
            cell.configView(dataSource: dataModel.feed)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collection1TableViewCell", for: indexPath as IndexPath) as! Collection1TableViewCell
            cell.configView(dataSource: dataModel.feed)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedLabelTableViewCell", for: indexPath as IndexPath) as! FeedLabelTableViewCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collection2TableViewCell", for: indexPath as IndexPath) as! Collection2TableViewCell
            cell.configView(dataSource: dataModel.feed)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath as IndexPath) as! FeedTableViewCell
            
            cell.feedImage.loadImage(urlString: dataModel.feed[indexPath.row].image)
            cell.feedLabel.text = dataModel.feed[indexPath.row].description
            cell.imgLblView.backgroundColor = .white
            cell.imgLblView.layer.cornerRadius = 5
            cell.imgLblView.clipsToBounds = true
            return cell
        default:
            return UITableViewCell()
        }
          
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2  || indexPath.section == 3 {
            return 128
        }
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    
}

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




