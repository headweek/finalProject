//
//  VKController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class VKController: UIViewController {
    //new
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
        VKService.getWall { result in
            switch result {
            case .success(let vkData):
                print(vkData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //new
        profileViewModel.loadProfileInfo { [weak self] in
            DispatchQueue.main.async {
                self?.updateNavigationBar()
            }
        }
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

    @objc func moreButtonTapped() {
        //выход из ВК
    }
    
    //MARK: Funcitons
    private func settupView() {
        view.backgroundColor = .viewColor
        view.addSubview(collection)
    }
    //MARK: View elements
    private lazy var collection: UICollectionView = {
        $0.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseId)
        $0.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.itemSize = CGSize(width: view.frame.width - 40, height: 400)
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 100
        $0.headerReferenceSize = CGSize(width: view.bounds.width, height: 90)
        return $0
    }(UICollectionViewFlowLayout())
    //MARK: Action elements

}

extension VKController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { return UICollectionViewCell() }
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
