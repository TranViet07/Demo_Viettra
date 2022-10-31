//
//  FeedItem.swift
//  Demo
//
//  Created by TRANVIET on 04/10/2022.
//

import Foundation

struct Feed: Codable {
    let image: String
    let description: String

}

struct Feeds: Codable {
    var feed: [Feed]
}
