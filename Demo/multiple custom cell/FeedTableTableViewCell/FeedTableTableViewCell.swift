//
//  FeedTableTableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 25/10/2022.
//

import UIKit

class FeedTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ViewController.feed.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! FeedTableViewCell
//        cell.backgroundColor = .clear
//        cell.feedImage.loadImage(urlString: ViewController.feed[indexPath.row].image)
//        cell.feedLabel.text = ViewController.feed[indexPath.row].description
//        cell.imgLblView.backgroundColor = .white
//        cell.imgLblView.layer.cornerRadius = 5
//        cell.imgLblView.clipsToBounds = true
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
}
