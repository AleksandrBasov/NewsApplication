//
//  DataService.swift
//  News
//
//  Created by Александр Басов on 12/7/21.
//

import UIKit
import RealmSwift

class DataService {
    private init() { }
    static let shared = DataService()
    
    let realm = try! Realm()
    
    var news: [NewsRealm] {
        let results = realm.objects(NewsRealm.self)
        return Array(results)
    }

    func save(array: [NewsRealm]) {
        try? self.realm.write({
            self.realm.delete(news)
            self.realm.add(array)
        })
    }
    
}
