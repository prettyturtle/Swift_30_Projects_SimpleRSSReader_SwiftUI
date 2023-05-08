//
//  NewsItem.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import Foundation

struct NewsItem: Decodable, Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let link: String
    let description: String
    let pubDate: String
    
    
    static let mocks: [Self] = (1...10).map {
        NewsItem(
            title: "title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)title\($0)",
            link: "link\($0)",
            description: "description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)description\($0)",
            pubDate: "pubDate\($0)"
        )
    }
}
