//
//  StorageController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class StorageController: UIViewController {
    
    var profileViewModel = ProfileViewModel()
    private var cData = CoreManager.shared
    
    lazy var profileImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return $0
    }(UIImageView())
    
    lazy var nameLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    //MARK: ViewLifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
        
        profileViewModel.loadProfileInfo { [weak self] in
            DispatchQueue.main.async {
                self?.updateNavigationBar()
            }
        }
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
    }
    //MARK: View elements
    private lazy var collection: UICollectionView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(StorageCell.self, forCellWithReuseIdentifier: StorageCell.reuseId)
        $0.register(StorageVKCell.self, forCellWithReuseIdentifier: StorageVKCell.reuseId)
        $0.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        $0.headerReferenceSize = CGSize(width: view.bounds.width, height: 90)
        return $0
    }(UICollectionViewFlowLayout())
    
    //MARK: Action elements
}

extension StorageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cData.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageCell.reuseId, for: indexPath)
        let storageManager = StorageManager()
        let data = cData.posts[indexPath.item]
        if let id = data.id {
            let item = ItemData(id: id, imageURL: data.image, link: data.link, date: data.date, description: data.discription, title: data.title, content: nil, author: nil, addStorage: true)
            if let imageData = storageManager.loadImage(item.id) {
                if let image = UIImage(data: imageData) {
                    if item.link == nil {
                        if let vkCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageVKCell.reuseId, for: indexPath) as? StorageVKCell {
                            vkCell.configCellForVk(item, image: image, imageId: item.id)
                            vkCell.delegate = self
                            vkCell.stopActivity()
                            cell = vkCell
                        }
                    } else {
                        if let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageCell.reuseId, for: indexPath) as? StorageCell {
                            newsCell.configCellForNews(item, image: image, imageId: item.id)
                            newsCell.delegate = self
                            newsCell.stopActivity()
                            cell = newsCell
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return UICollectionReusableView() }
        header.configCell("Хранилище")
        return header
    }
}

extension StorageController: UICollectionViewDelegate {
    
}

extension StorageController: StorageCellDelegate {
    func updateData() {
        self.collection.reloadData()
    }
    
    func openSafariLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
