//
//  VkCell.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import UIKit

protocol CellDelegate: AnyObject {
    func openSafariLink(url: String)
    func reloadData(itemData: ItemData?)
}

final class Cell: UICollectionViewCell {
    
    private let cData = CoreManager.shared
    private var itemData: ItemData?
    private var url = String()
    
    static let reuseId = "Cell"
    
    weak var delegate: CellDelegate?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupCell()
        addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    private func settupCell() {
        backgroundColor = .viewColor
        addSubview(image)
        addSubview(moveToStorageBtn)
        
        linkLabel.addGestureRecognizer(tapToLinkGesture)
        linkLabel.isUserInteractionEnabled = true
        
        layer.cornerRadius = 20
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.shadowPath = path
        layer.shadowColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 250),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            
            moveToStorageBtn.topAnchor.constraint(equalTo: image.topAnchor, constant: 25),
            moveToStorageBtn.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
        ])
        
    }
    
    func configCell(_ data: ItemData, image: UIImage) {
        self.itemData = data
        if data.addStorage {
            self.moveToStorageBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            self.moveToStorageBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        self.image.image = image
        if let link = data.link {
            self.url = link
            self.linkLabel.text = link.toHost
            addSubview(linkLabel)
            NSLayoutConstraint.activate([
                linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                linkLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10),
                linkLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ])
        }
        if let date = data.date {
            self.dateLabel.text = date
            addSubview(dateLabel)
            if data.link == nil {
                NSLayoutConstraint.activate([
                    dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    dateLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 8),
                ])
            } else {
                NSLayoutConstraint.activate([
                    dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    dateLabel.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 8),
                ])
            }
        }
        if let title = data.title {
            self.titleLabel.text = title
            addSubview(titleLabel)
            if data.date == nil {
                NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    titleLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10),
                ])
            } else {
                NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                ])
            }
        }
        if let description = data.description {
            self.descriptionLabel.text = description
            addSubview(descriptionLabel)
            if data.title == nil {
                NSLayoutConstraint.activate([
                    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                    descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                ])
            } else {
                NSLayoutConstraint.activate([
                    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                    descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                ])
            }
        }
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    //MARK: View
    private lazy var tapToLinkGesture: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(moveToSafari(sender: )))
        return $0
    }(UITapGestureRecognizer())
    
    private lazy var moveToStorageBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.tintColor = .black
        return $0
    }(UIButton(primaryAction: moveToStorageAction))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.style = .large
        $0.color = .black
        $0.startAnimating()
        $0.center = center
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var linkLabel = ViewManager.getLinkLabel()
    private lazy var titleLabel = ViewManager.getLabel("",textColor: .black, textAligment: .left, font: .boldSystemFont(ofSize: 20))
    private lazy var descriptionLabel = ViewManager.getLabel("",textColor: .black ,textAligment: .left, font: .systemFont(ofSize: 14), numberOfLines: 10)
    private lazy var dateLabel = ViewManager.getLabel("",textColor: .lightGray,textAligment: .left, font: .systemFont(ofSize: 14))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    //MARK: Action
    private lazy var moveToStorageAction = UIAction { [weak self] _ in
        guard let self else { return }
        guard let image = self.image.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        guard let itemData else { return }
        guard let date = itemData.date else { return }
        let storage = StorageManager()
        let posts = cData.posts
        
        if itemData.addStorage {
            for post in posts {
                if let id = post.id {
                    if id == "\(itemData.id)\(date)" {
                        self.itemData?.addStorage = false
                        self.moveToStorageBtn.setImage(UIImage(systemName: "star"), for: .normal)
                        post.deleteData()
                        storage.deleteImg("\(itemData.id)\(date)")
                        delegate?.reloadData(itemData: self.itemData)
                    }
                }
            }
        } else {
            self.itemData?.addStorage = true
            self.moveToStorageBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cData.createData(item: itemData)
            storage.saveImage(imageData, imageName: "\(itemData.id)\(date)")
            delegate?.reloadData(itemData: self.itemData)
        }

    }
    
    @objc func moveToSafari(sender: UITapGestureRecognizer) {
        delegate?.openSafariLink(url: self.url)
    }
}
