//
//  NewsListViewModel.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import Foundation
import Combine

// http://www.apple.com/main/rss/hotnews/hotnews.rss
final class NewsListViewModel: ObservableObject {
    @Published var newsList: [NewsItem] = []
    @Published var selectedItem: NewsItem?
    
    private var store = Set<AnyCancellable>()
    
    func checkSelected(item: NewsItem) -> Bool {
        return selectedItem?.id == item.id
    }
    
    func fetchNews() {
        let urlString = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
        
        if let url = URL(string: urlString) {
            let xmlParserManager = XMLParserManager(url: url)
            
            xmlParserManager
                .startParse(type: [NewsItem].self)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished:
                        print("FINISHED")
                    }
                } receiveValue: { list in
                    self.newsList = list
                }
                .store(in: &store)
        }
    }
}
