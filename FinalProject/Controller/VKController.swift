//
//  VKController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit
import AudioToolbox

final class VKController: UIViewController {
    //new
    var profileViewModel = ProfileViewModel()
    private var vkData = [ItemData]()
    private var images = [String: UIImage]()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataByNotify(notification: )), name: NSNotification.Name("reloadData"), object: nil)
        
        view.backgroundColor = .viewColor
        getData()
        //new
        profileViewModel.loadProfileInfo { [weak self] in
            DispatchQueue.main.async {
                self?.updateNavigationBar()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collection.reloadData()
    }
    
    //new
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
    
    @objc
    func reloadDataByNotify(notification: Notification) {
        guard let newData = notification.userInfo?["reloadData"] as? ItemData else { return }
        self.vkData.forEach { item in
            if let index = self.vkData.firstIndex(where: { $0.description == newData.description }) {
                self.vkData[index].addStorage = newData.addStorage
            }
        }
    }
    
    private func getData() {
        VKService.getWall { [weak self] result in
            AudioServicesPlaySystemSound(SystemSoundID(1030))
            guard let self else { return }
            switch result {
            case .success(let vkData):
                let data = vkData
                var items = [ItemData]()
                
                for item in data.response.items {
                    let text = item.text
                    let id = item.id
                    let date = TimeManager.getStringDate(Date(timeIntervalSince1970: TimeInterval(item.date)))
                    var url = String()
                    let attachments = item.attachments
                    for attachment in attachments {
                        if let photo = attachment.photo {
                            for size in photo.sizes {
                                if size.height == photo.sizes.last?.height {
                                    url = size.url
                                }
                            }
                        }
                        if let video = attachment.video {
                            for image in video.image {
                                if image.height == video.image.last?.height {
                                    url = image.url
                                }
                            }
                        }
                    }
                    
                    var isAddStorage = false
                    
                    let storgateData = CoreManager.shared.posts
                    for storageItem in storgateData {
                        let itemId = "\(id)\(date)"
                        if let storageId = storageItem.id {
                            if itemId == storageId {
                                isAddStorage = true
                            }
                        }
                        
                    }
                    
                    let itemData = ItemData(id: String(id), imageURL: url, link: nil, date: date, description: text, title: nil, content: nil, author: nil, addStorage: isAddStorage)
                    items.append(itemData)
                }
                
                
                self.vkData = items
                
                var countForCallSettupView = items.count
                
                for item in items {
                    if let urlString = item.imageURL {
                        if let url = URL(string: urlString) {
                            ImageLoader.loadImage(from: url) { image in
                                if let image = image {
                                    self.getImages(image, imageName: urlString)
                                    countForCallSettupView -= 1
                                    if countForCallSettupView == 0 {
                                        self.settupView()
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
    }
    
    private func getImages(_ image: UIImage, imageName: String) {
        self.images[imageName] = image
    }
    
    private func settupView() {
        DispatchQueue.main.async {
            self.collection.reloadData()
            self.view.backgroundColor = .viewColor
            self.view.addSubview(self.collection)
        }
    }
    //MARK: View elements
    private lazy var collection: UICollectionView = {
        $0.register(VKCell.self, forCellWithReuseIdentifier: VKCell.reuseId)
        $0.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.headerReferenceSize = CGSize(width: view.bounds.width, height: 90)
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    //MARK: Action elements

}

extension VKController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vkData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VKCell.reuseId, for: indexPath) as? VKCell else { return UICollectionViewCell() }
        cell.delegate = self
        let data = vkData[indexPath.item]
        guard let urlString = data.imageURL else { return UICollectionViewCell() }
        guard let image = self.images[urlString] else { return UICollectionViewCell() }
        cell.configCell(data, image: image)
        cell.stopActivity()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return UICollectionReusableView() }
        header.configCell("Error Nil VK")
        return header
    }
}

extension VKController: UICollectionViewDelegate {
    
}

extension VKController: VKCellDelegate {
    func reloadData(itemData: ItemData?) {
        guard let itemData else { return }
        self.vkData.forEach { item in
            if let index = self.vkData.firstIndex(where: { $0.id == itemData.id }) {
                self.vkData[index].addStorage = itemData.addStorage
            }
        }
    }
}
