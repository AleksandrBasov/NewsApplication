//
//  Tag.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import UIKit

class Tag {
    var isActive: Bool
    var type: TagType
    
    init(isActive: Bool = false, type: TagType) {
        self.isActive = isActive
        self.type = type
    }
}

enum TagType: CaseIterable {
    case general
    case business
    case science
    case technology
    case health
    case entertainment
    case sport
    case save
    
    var title: String {
        switch self {
            case .general:          return "General"
            case .business:         return "Business"
            case .science:          return "Science"
            case .technology:       return "Technology"
            case .health:           return "Health"
            case .entertainment:    return "Entertainment"
            case .sport:            return "Sports"
            case .save:             return "Save"
        }
    }
    
    var image: UIImage? {
        switch self {
            case .general:          return UIImage(named: "General")
            case .business:         return UIImage(named: "Business")
            case .science:          return UIImage(named: "Science")
            case .technology:       return UIImage(named: "Technology")
            case .health:           return UIImage(named: "Health")
            case .entertainment:    return UIImage(named: "Entertainment")
            case .sport:            return UIImage(named: "Sports")
            case .save:             return UIImage(named: "Save")
        }
    }
    
    var color: UIColor {
        switch self {
            case .general:          return .red
            case .business:         return .blue
            case .science:          return #colorLiteral(red: 0.8468264249, green: 0.7443109102, blue: 0.1361088806, alpha: 1)
            case .technology:       return .purple
            case .health:           return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            case .entertainment:    return #colorLiteral(red: 0.2694163481, green: 0.7083468264, blue: 0.7033297362, alpha: 1)
            case .sport:            return .orange
            case .save:             return #colorLiteral(red: 0.2339959122, green: 0.8528173575, blue: 0.2159427912, alpha: 1)
        }
    }
}
