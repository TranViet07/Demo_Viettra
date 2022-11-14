//
//  FeedTableTableViewCell.swift
//  Demo
//
//  Created by TRANVIET on 25/10/2022.
//

import UIKit

class FeedTableTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var feedTableView: UITableView!
    
    private var dataSource: [Feed] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        feedTableView.separatorStyle = .none
        feedTableView.reloadData()
        super.layoutIfNeeded()
        print("feedContent = \(contentView.frame.height)")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
                           
    func configView(dataSource: [Feed]) {
        self.dataSource = dataSource
        feedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath as IndexPath) as! FeedTableViewCell
        
        cell.feedImage.loadImage(urlString: dataSource[indexPath.row].image)
        cell.feedLabel.text = dataSource[indexPath.row].description
        cell.imgLblView.backgroundColor = .white
        cell.imgLblView.layer.cornerRadius = 5
        cell.imgLblView.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.reloadInputViews()
    }
    
    
}
