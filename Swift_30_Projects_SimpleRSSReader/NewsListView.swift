//
//  NewsListView.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject var viewModel: NewsListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.newsList, id: \.id) { newsItem in
                
                Button {
                    withAnimation {
                        viewModel.selectedItem = viewModel.checkSelected(item: newsItem) ? nil : newsItem
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(newsItem.title)
                            .font(.title)
                            .bold()
                        Text(newsItem.pubDate)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(newsItem.description)
                            .font(.body)
                            .lineLimit(viewModel.checkSelected(item: newsItem) ? .max : 4)
                    }
                }
                .buttonStyle(.plain)
                
                
                .listRowInsets(
                    EdgeInsets(
                        top: 16,
                        leading: 16,
                        bottom: 16,
                        trailing: 16
                    )
                )
            }
            
            .navigationTitle("Apple News")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: NewsListViewModel())
    }
}
// http://www.apple.com/main/rss/hotnews/hotnews.rss
