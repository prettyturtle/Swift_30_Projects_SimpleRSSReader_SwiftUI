//
//  NewsListViewModel.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import Foundation

final class NewsListViewModel: ObservableObject {
    @Published var newsList = NewsItem.mocks
    @Published var selectedItem: NewsItem?
    
    func checkSelected(item: NewsItem) -> Bool {
        return selectedItem?.id == item.id
    }
}
