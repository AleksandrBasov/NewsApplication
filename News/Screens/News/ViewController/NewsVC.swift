//
//  NewsVC.swift
//  News
//
//  Created by Александр Басов on 12/5/21.
//

import UIKit
import SafariServices

class NewsVC: UIViewController {
    
    // - UI
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // - ViewModel
    private let viewModel = NewsViewModel()
    
    // - Managers
    private let network = NetworkManager()
    
    private var filteredNews: [Article] = []
    private var newsArticles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - TableViewDataSource
extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        cell.set(news: viewModel.filterNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.filterNews[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

// MARK: - TableViewDataSource
extension NewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseID, for: indexPath) as! TagCell
        cell.set(tag: viewModel.tags[indexPath.row].type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.tags[indexPath.row].type {
        case .general:
            fetchData(category: .general)
        case .business:
            fetchData(category: .business)
        case .science:
            fetchData(category: .science)
        case .technology:
            fetchData(category: .technology)
        case .health:
            fetchData(category: .health)
        case .entertainment:
            fetchData(category: .entertainment)
        case .sport:
            fetchData(category: .sport)
        case .save:
            viewModel.saveNews()
        }
        self.navigationItem.title = viewModel.tags[indexPath.row].type.title
        tableView.setContentOffset(.zero, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .init(scaleX: 0.92, y: 0.92)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .identity
            }
        }
    }
}

// MARK: - Update
private extension NewsVC {
    
    func updateTags(tag: Tag) {
        if tag.isActive {
            tag.isActive = false
        } else {
            tag.isActive = true
        }
    }
}

// MARK: - FetchData
private extension NewsVC {
    
    func fetchData(category: TagType) {
        network.getNews(category: category) { articles in
            self.viewModel.updateNews(articles: articles)
            self.tableView.reloadData()
        } onError: { error in
            print(error)
        }
    }
    
}

// MARK: - Configure
private extension NewsVC {
    
    func configure() {
        fetchData(category: .general)
        configureTableView()
        configureCollectionView()
        configureCollectionViewLayout()
        configureSearchBar()
        showOnboarding()
    }
    
    func configureTableView() {
        tableView.register(NewsCell.nib(), forCellReuseIdentifier: NewsCell.reuseID)
    }
    
    func configureCollectionView() {
        collectionView.register(TagCell.nib(), forCellWithReuseIdentifier: TagCell.reuseID)
    }
    
    func configureCollectionViewLayout() {
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionViewLayout?.minimumLineSpacing = 10
        collectionViewLayout?.invalidateLayout()
    }
    
    func  configureSearchBar() {
        searchBar.delegate = self
    }
}


//MARK: - SearchBar
extension NewsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}


//MARK: - onboarding
private extension NewsVC {
    func showOnboarding() {
        if Core.shared.isNewUser() {
            //show onboarding
            let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController() as! WelcomeViewController
            presentPanModal(vc)
        }
    }
}




