//
//  NewsViewModel.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import Foundation

class NewsViewModel {
    
    // - Data
    private var news: [Article] = []
    var tags: [Tag] = [Tag(type: .general),
                       Tag(type: .business),
                       Tag(type: .science),
                       Tag(type: .technology),
                       Tag(type: .health),
                       Tag(type: .entertainment),
                       Tag(type: .sport),
                       Tag(type: .save)]
    var searchText = ""
    var filterNews: [Article] {
        
        var filterNews = news
        filterNews = filterNews.filter({ (article) -> Bool in
            return searchText.isEmpty ? true : (article.title?.lowercased().contains(searchText.lowercased()) ?? false )
        })
        
        return filterNews
    }
    
    func updateNews(articles: [Article]) {
        self.news = articles
    }
    
    func saveNews() {
        let newsRealm: [NewsRealm] = news.map { NewsRealm.convert(article: $0 )}
        DataService.shared.save(array: newsRealm)
    }
    
}
