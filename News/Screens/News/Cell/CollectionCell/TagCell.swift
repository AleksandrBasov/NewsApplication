//
//  TagCell.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    // - UI
    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    // - Register Cell
    static let reuseID = "TagCell"
    static func nib() -> UINib {
        return UINib(nibName: "TagCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func set(tag: TagType) {
        tagTitle.text = tag.title
        tagTitle.textColor = tag.color
        tagIcon.image = tag.image
    }
}

// MARK: - Configure
private extension TagCell {
    
    func configure() {
        configureShadow()
    }
    
    func configureShadow() {
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius = 3
    }
    
}
