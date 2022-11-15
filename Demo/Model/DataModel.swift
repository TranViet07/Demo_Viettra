//
//  DataModel.swift
//  Demo
//
//  Created by TRANVIET on 15/11/2022.
//

import Foundation
class DataModel {
    
    var feed = [Feed]()
    
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
    
}

struct Feed: Codable {
    let image: String
    let description: String

}

struct Feeds: Codable {
    var feed: [Feed]
}
