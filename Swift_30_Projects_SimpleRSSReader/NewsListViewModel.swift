//
//  NewsListViewModel.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import Foundation
// http://www.apple.com/main/rss/hotnews/hotnews.rss
final class NewsListViewModel: ObservableObject {
    @Published var newsList: [NewsItem] = []
    @Published var selectedItem: NewsItem?
    
    func checkSelected(item: NewsItem) -> Bool {
        return selectedItem?.id == item.id
    }
    
    func fetchNews() {
        let urlString = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
        
        if let url = URL(string: urlString) {
            let xmlParserManager = XMLParserManager(url: url)
            
            newsList = xmlParserManager.startParse(type: [NewsItem].self)
        }
    }
}
