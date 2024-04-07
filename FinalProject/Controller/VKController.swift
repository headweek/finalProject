//
//  VKController.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class VKController: UIViewController {

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
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
        10
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
