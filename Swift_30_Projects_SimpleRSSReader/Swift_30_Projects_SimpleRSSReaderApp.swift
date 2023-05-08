//
//  Swift_30_Projects_SimpleRSSReaderApp.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/08.
//

import SwiftUI

@main
struct Swift_30_Projects_SimpleRSSReaderApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListView(viewModel: NewsListViewModel())
        }
    }
}
