//
//  NewsRealm.swift
//  News
//
//  Created by Александр Басов on 12/11/21.
//

import Foundation
import RealmSwift

class NewsRealm: Object {
    @Persisted var title: String = ""
    @Persisted var descriptionText: String = ""
    @Persisted var publishedAt: String = ""
    @Persisted var source: SourceRealm? = SourceRealm()
    
    override public static func primaryKey() -> String? {
        return "title"
    }
    
    static func convert(article: Article) -> NewsRealm {
        let realm = NewsRealm()
        realm.title = article.title ?? ""
        realm.descriptionText = article.description ?? ""
        realm.publishedAt = article.publishedAt
        realm.source = SourceRealm.convert(source: article.source)
        return realm
    }
}

class SourceRealm: Object {
    @Persisted var name: String = ""
    
    static func convert(source: Source) -> SourceRealm {
        let realm = SourceRealm()
        realm.name = source.name ?? ""
        return realm
    }
}



