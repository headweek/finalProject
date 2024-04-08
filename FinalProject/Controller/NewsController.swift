//
//  NewsController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class NewsController: UIViewController {

    private var newsData = [ItemData]()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
    }

    //MARK: Funcitons
    private func settupView() {
        view.backgroundColor = .viewColor
        view.addSubview(collection)
        navigationItem.searchController = searchController
    }
    //MARK: View elements
    private lazy var searchController: UISearchController = {
        $0.searchBar.returnKeyType = .default
        $0.searchBar.searchTextField.delegate = self
        return $0
    }(UISearchController())
    
    private lazy var collection: UICollectionView = {
        $0.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseId)
        $0.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.headerReferenceSize = CGSize(width: view.frame.width, height: 90)
        $0.itemSize = CGSize(width: view.frame.width - 40, height: 600)
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 100
        return $0
    }(UICollectionViewFlowLayout())
    //MARK: Action elements

}

extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { return UICollectionViewCell() }
        let news = newsData[indexPath.item]
        if let urlString = news.imageURL {
            if let url = URL(string: urlString) {
                ImageLoader.loadImage(from: url) { image in
                    guard let image else { return }
                    cell.configCell(news, image: image)
                    cell.stopActivity()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return UICollectionViewCell() }
        header.configCell("Новости")
        return header
    }
}

extension NewsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = newsData[indexPath.item]
        if let urlString = news.imageURL {
            if let url = URL(string: urlString) {
                ImageLoader.loadImage(from: url) { image in
                    guard let image else { return }
                    let vc = FullInforamtionController()
                    vc.configView(image: image, data: news)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension NewsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        NewsServices.getNews(q: text, pageSize: 10) { result in
            switch result {
            case .success(let newsData):
                var newsModel = [ItemData]()
                for items in newsData.articles {
                    let item = ItemData(id: UUID().uuidString, imageURL: items.urlToImage, link: items.url, date: items.publishedAt, description: items.description, title: items.title, content: items.content, author: items.author)
                    newsModel.append(item)
                }
                self.newsData = newsModel
                DispatchQueue.main.async {
                    self.collection.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.searchController.isActive = false
        return true
    }
}
