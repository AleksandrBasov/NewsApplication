//
//  Core.swift
//  News
//
//  Created by Александр Басов on 12/7/21.
//

import Foundation

class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func isNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
