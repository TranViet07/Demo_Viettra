//
//  ViewController.swift
//  Demo
//
//  Created by TRANVIET on 04/10/2022.	
//

import UIKit

class ViewController: UIViewController {
    
    var feed = [Feed]()
    
    let item = ["Facebook", "Instagram", "Youtube", "Shopee", "Bank", "Bookmark", "Interrogation", "More"]
    var navigateApp: String = ""
    let urlString = "https://69b6b792-2919-4041-a084-4182464efd6e.mock.pstmn.io/feeds"
    
    @IBOutlet weak var homeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = UIColor(named: "lightGreen")
        
        
        homeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        homeTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        homeTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        homeTableView.register(UINib(nibName: "Collection1TableViewCell", bundle: nil), forCellReuseIdentifier: "Collection1TableViewCell")
        homeTableView.register(UINib(nibName: "FeedLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedLabelTableViewCell")
        homeTableView.register(UINib(nibName: "Collection2TableViewCell", bundle: nil), forCellReuseIdentifier: "Collection2TableViewCell")
        homeTableView.register(UINib(nibName: "FeedTableTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableTableViewCell")
        

        homeTableView.refreshControl = UIRefreshControl()
        homeTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        customRefresh()
        
    }
    
    
    
    // pull to refresh
    
    
        @objc func pullToRefresh() {
            DispatchQueue.main.async {
                self.viewWillAppear(true)
                self.homeTableView.refreshControl?.endRefreshing()
            }
    
        }
    
        func customRefresh(){
            let target = self.homeTableView.refreshControl
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
            target?.tintColor = .white
            target?.attributedTitle = .init(string: "Refreshing", attributes: attributes)
    
        }
    
    func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        if let feedJson = try? decoder.decode(Feeds.self, from: json) {
            feed = feedJson.feed
        }
    }
    
    func getData() {
        if let url = URL.init(string : urlString){
            if let data = try? Data(contentsOf: url){
                parseJSON(json: data)
            }
        }
    }
    
    func scrollToTop() {
        self.homeTableView.contentOffset.y = .zero
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeTableView.reloadData()
        scrollToTop()
    }
    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return item.count
        } else if collectionView.tag == 1 {
            return 1
        } else {
            return feed.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath as IndexPath) as! MenuCollectionViewCell
            cell.itemImage.image = UIImage(named: item[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.itemImage.tintColor = UIColor(named: "darkBlue")
            cell.itemLabel.text = item[indexPath.row]
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath as IndexPath) as! FirstCollectionViewCell
            cell.backgroundColor = .clear
            cell.firstCollectionViewImage.loadImage(urlString: feed[indexPath.row].image)
            cell.firstCollectionViewLabel?.text = feed[indexPath.row].description + "\nCELL: \(indexPath.row + 1)"
            cell.firstCollectionViewContainer.backgroundColor = .white
            cell.firstCollectionViewContainer.layer.cornerRadius = 5
            cell.firstCollectionViewContainer.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath as IndexPath) as! SecondCollectionViewCell
            cell.secondCollectionViewCellImg.loadImage(urlString: feed[indexPath.row].image)
            cell.secondCollectionViewCellImg.layer.cornerRadius = 5
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            navigateApp = item[indexPath.row]
            UIApplication.shared.open(URL(string: "http://\(navigateApp).com/")!)
        }

    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width/3.5, height: collectionView.frame.size.height/4)
//    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == homeTableView {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath as IndexPath) as! MenuTableViewCell
                cell.menuLabel.text = "Good \(currentTime())!"
                cell.menuCollectionView.delegate = self
                cell.menuCollectionView.dataSource = self
                cell.menuCollectionView.tag = 0
                cell.menuCollectionView.backgroundColor = .none
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath as IndexPath) as! SearchTableViewCell
                return cell
            }
            else if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Collection1TableViewCell", for: indexPath as IndexPath) as! Collection1TableViewCell
                cell.collection1.delegate = self
                cell.collection1.dataSource = self
                return cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedLabelTableViewCell", for: indexPath as IndexPath) as! FeedLabelTableViewCell
                return cell
            }
            else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Collection2TableViewCell", for: indexPath as IndexPath) as! Collection2TableViewCell
                cell.collection2.delegate = self
                cell.collection2.dataSource = self
                cell.collection2.tag = 2
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableTableViewCell", for: indexPath as IndexPath) as! FeedTableTableViewCell
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath as IndexPath) as! FeedTableViewCell
            cell.backgroundColor = .clear
            cell.feedImage.loadImage(urlString: feed[indexPath.row].image)
            cell.feedLabel.text = feed[indexPath.row].description
            cell.imgLblView.backgroundColor = .white
            cell.imgLblView.layer.cornerRadius = 5
            cell.imgLblView.clipsToBounds = true
            return cell

        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.reloadInputViews()
        
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




