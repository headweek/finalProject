//
//  NewsController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class NewsController: UIViewController {

    private var newsData = [ItemData]()
    private var images = [String : UIImage]()
    
    var profileViewModel = ProfileViewModel()
    
    lazy var profileImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32)))
    
    lazy var nameLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
        profileViewModel.loadProfileInfo { [weak self] in
            DispatchQueue.main.async {
                self?.updateNavigationBar()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    
    func updateNavigationBar() {
        
        view.addSubview(profileImageView)
        if let profileImage = profileViewModel.profileImage {
            profileImageView.image = profileImage
        }
        
        view.addSubview(nameLabel)
        if let user = profileViewModel.user {
            nameLabel.text = "\(user.firstName) \(user.lastName)"
        }
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        let profileBarButton = UIBarButtonItem(customView: stackView)
        navigationItem.leftBarButtonItem = profileBarButton
        
        let moreButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(moreButtonTapped))
        navigationItem.rightBarButtonItem = moreButton
    }
    
    func logoutFromVK() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let logoutAction = UIAlertAction(title: "Выход", style: .destructive) { _ in
                UserDefaults.standard.removeObject(forKey: .accessToken)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil, userInfo: ["isLogin" : false])
            }
            alertController.addAction(logoutAction)

            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
    }

    @objc func moreButtonTapped() {
        //выход из ВК
        logoutFromVK()
    }

    //MARK: Funcitons
    private func settupView() {
        view.backgroundColor = .viewColor
        view.addSubview(collection)
        navigationItem.searchController = searchController
    }
    private func getImages(_ image: UIImage, imageName: String) {
        self.images[imageName] = image
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
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
        guard let urlString = news.imageURL else { return UICollectionViewCell() }
        guard let image = self.images[urlString] else { return UICollectionViewCell() }
        cell.delegate = self
        cell.configCell(news, image: image)
        cell.stopActivity()
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
                    if let id = items.source.id {
                        var isAddStorage = false
                        
                        let storgateData = CoreManager.shared.posts
                        
                        var date = String()
                        
                        if let dateStr = items.publishedAt {
                            for char in dateStr {
                                if char != "T"  {
                                    date += String(char)
                                } else { break }
                                
                            }
                        }
                        
                        for storageItem in storgateData {
                            let itemId = "\(id)\(date)"
                            
                            if let storageId = storageItem.id {
                                if itemId == storageId {
                                    isAddStorage = true
                                }
                            }
                            
                        }
                        let item = ItemData(id: id, imageURL: items.urlToImage, link: items.url, date: date, description: items.description, title: items.title, content: items.content, author: items.author, addStorage: isAddStorage)
                        newsModel.append(item)
                    }
                }
                
                var countItems = newsModel.count
                
                self.newsData = newsModel
                
                for item in newsModel {
                    if let urlString = item.imageURL {
                        if let url = URL(string: urlString) {
                            ImageLoader.loadImage(from: url) { image in
                                if let image = image {
                                    self.getImages(image, imageName: urlString)
                                    countItems -= 1
                                    if countItems == 0 {
                                        DispatchQueue.main.async {
                                            self.collection.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.searchController.isActive = false
        return true
    }
}

extension NewsController: CellDelegate {
    func openSafariLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
