//
//  NewsCell.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var dateNews: UILabel!

    
    // - Register Cell
    static let reuseID = "NewsCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewsCell",
                     bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func set(news: Article) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        
        
        if let imageUrl = news.urlToImage {
            NetworkManager.shared.getImage(imageURL: imageUrl, imageView: self.newsImage, indicator: self.activityIndicator)
        } else {
            self.newsImage.image = UIImage(named: "placeholder")
        }
        self.newsImage.layer.cornerRadius = 15
        nameAuthor.text = news.source.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: news.publishedAt)!

        dateFormatter.dateFormat = nil
        dateFormatter.dateFormat = "dd/MM' at 'HH:mm"
        let local = dateFormatter.string(from: date)
        
        dateNews.text = local
    }
}
