//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Александр Басов on 11/10/21.
//

import UIKit

class NetworkManager {
    
    init() { }

    static let shared = NetworkManager()
    
    let session = URLSession(configuration: .default)
    let urlSession = URLSession.shared
    
    let baseUrlString = "https://newsapi.org/v2/"
    let UsTopHeadline = "top-headlines?"
    let urlCountry = "country=ru"
    

//MARK: - GetNews
    func getNews(category: TagType, onSuccess: @escaping ([Article]) -> Void, onError: @escaping (String) -> Void) {
        let url = "\(baseUrlString)\(UsTopHeadline)\(urlCountry)&category=\(category.title.lowercased())&apiKey=\(APIKey.key)"
        
        guard let urrl = URL(string: url) else {
            onError("Error building URL")
            return
        }

        let task = session.dataTask(with: urrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }

                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Result.self, from: data)
                        print("Articles: \(result.articles.count)")
                        onSuccess(result.articles)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
//MARK: - GetImage
    func getImage(imageURL: String, imageView: UIImageView, indicator: UIActivityIndicatorView) {
        
        guard let url = URL(string: imageURL) else { return }

        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    indicator.stopAnimating()
                    imageView.image = image
                }
            }
        }.resume()
    }
}
