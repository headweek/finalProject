//
//  StorageCell.swift
//  FinalProject
//
//  Created by apple on 18.04.2024.
//

import UIKit

protocol StorageCellDelegate: AnyObject{
    func updateData()
    func openSafariLink(url: String)
}

final class StorageCell: UICollectionViewCell {
    
    static let reuseId = "StorageCell"
    private var itemData: ItemData?
    private var url = String()
    private var imageId = String()
    
    weak var delegate : StorageCellDelegate?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupView()
        addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    private func settupView() {
        backgroundColor = .viewColor
        clipsToBounds = true
    }
    
    func configCellForVk(_ data: ItemData, image: UIImage, imageId: String) {
        self.itemData = data
        self.image.image = image
        self.descriptionLabel.text = data.description
        self.dateLabel.text = data.date
        self.imageId = imageId
        addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cellView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
        ])
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func configCellForNews(_ data: ItemData, image: UIImage, imageId: String) {
        self.itemData = data
        self.imageId = imageId
        addSubview(self.image)
        addSubview(deleteToStorageBtn)
        NSLayoutConstraint.activate([
            self.image.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.image.topAnchor.constraint(equalTo: topAnchor),
            self.image.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.image.heightAnchor.constraint(equalToConstant: 250),
            self.image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            
            deleteToStorageBtn.topAnchor.constraint(equalTo: self.image.topAnchor, constant: 25),
            deleteToStorageBtn.trailingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: -20),
        ])
        self.image.image = image
        if let link = data.link {
            self.url = link
            self.linkLabel.text = link.toHost
            addSubview(linkLabel)
            self.linkLabel.addGestureRecognizer(tapToLinkGesture)
            self.linkLabel.isUserInteractionEnabled = true
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
    //MARK: View elements
    private lazy var cellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(image)
        $0.addSubview(deleteToStorageBtn)
        $0.addSubview(dateLabel)
        $0.addSubview(descriptionLabel)
    
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 1),
            image.topAnchor.constraint(equalTo: $0.topAnchor, constant: 1),
            image.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -1),
    
            deleteToStorageBtn.topAnchor.constraint(equalTo: image.topAnchor, constant: 25),
            deleteToStorageBtn.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
    
            dateLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
    
            descriptionLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -5),
        ])
        return $0
    }(UIView())

    private lazy var deleteToStorageBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return $0
    }(UIButton(primaryAction: deleteFromStorageAction))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.style = .large
        $0.color = .black
        $0.startAnimating()
        $0.center = center
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var descriptionLabel = ViewManager.getLabel("",textColor: .black ,textAligment: .left, font: .systemFont(ofSize: 14), numberOfLines: 10)
    private lazy var dateLabel = ViewManager.getLabel("",textColor: .lightGray,textAligment: .left, font: .systemFont(ofSize: 14))
    private lazy var linkLabel = ViewManager.getLinkLabel()
    private lazy var titleLabel = ViewManager.getLabel("",textColor: .black, textAligment: .left, font: .boldSystemFont(ofSize: 20))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var tapToLinkGesture: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(openSafariLinkAction(sender: )))
        return $0
    }(UITapGestureRecognizer())
    //MARK: Action elements
    private lazy var deleteFromStorageAction = UIAction { [weak self] _ in
        guard let self else { return }
        let storageManager = StorageManager()
        storageManager.deleteImg(imageId)
        let cData = CoreManager.shared
        print(self.imageId)
        for post in cData.posts where post.id == self.imageId {
            post.deleteData()
        }
        self.itemData?.addStorage = false
        if let itemData {
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil, userInfo: ["reloadData": itemData])
        }
        delegate?.updateData()
    }
    
    @objc
    func openSafariLinkAction(sender: UITapGestureRecognizer) {
        delegate?.openSafariLink(url: url)
    }
    
}




