//
//  ViewController.swift
//  Demo
//
//  Created by TRANVIET on 04/10/2022.	
//

import UIKit

class ViewController: UIViewController {
    
    var feed = [Feed]()
    
    let urlString = "https://69b6b792-2919-4041-a084-4182464efd6e.mock.pstmn.io/feeds"
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        getData(from: urlString)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = UIColor(named: "lightGreen")
        
        homeTableView.separatorStyle = .none
        
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
    
    func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        if let feedJson = try? decoder.decode(Feeds.self, from: json) {
            feed = feedJson.feed
        }
    }
    
    func getData(from urlString: String) {
        if let url = URL.init(string: urlString){
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToTop()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return feed.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath as IndexPath) as! MenuTableViewCell
            cell.menuLabel.text = "Good \(cell.currentTime())!"
            cell.menuCollectionView.backgroundColor = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath as IndexPath) as! SearchTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collection1TableViewCell", for: indexPath as IndexPath) as! Collection1TableViewCell
            cell.configView(dataSource: feed)
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedLabelTableViewCell", for: indexPath as IndexPath) as! FeedLabelTableViewCell
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collection2TableViewCell", for: indexPath as IndexPath) as! Collection2TableViewCell
            cell.configView(dataSource: feed)
            return cell
        } else if indexPath.section == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath as IndexPath) as! FeedTableViewCell
                
                cell.feedImage.loadImage(urlString: feed[indexPath.row].image)
                cell.feedLabel.text = feed[indexPath.row].description
                cell.imgLblView.backgroundColor = .white
                cell.imgLblView.layer.cornerRadius = 5
                cell.imgLblView.clipsToBounds = true
                return cell
        } else {
            return UITableViewCell()
        }
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 128
        }
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.reloadInputViews()
        cell.layoutIfNeeded()
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




