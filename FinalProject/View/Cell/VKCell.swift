//
//  VKCell.swift
//  FinalProject
//
//  Created by apple on 16.04.2024.
//

import UIKit

final class VKCell: UICollectionViewCell {
    private var url = String()
    static let reuseId = "VKCell"
    
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
        clipsToBounds = true
    }
    
    func configCell(_ data: ItemData, image: UIImage) {
        if data.addStorage {
            self.moveToStorageBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            self.moveToStorageBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        self.image.image = image
        self.descriptionLabel.text = data.description
        self.dateLabel.text = data.date
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
    
    //MARK: View elements
    private lazy var cellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(image)
        $0.addSubview(moveToStorageBtn)
        $0.addSubview(dateLabel)
        $0.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 1),
            image.topAnchor.constraint(equalTo: $0.topAnchor, constant: 1),
            image.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -1),

            moveToStorageBtn.topAnchor.constraint(equalTo: image.topAnchor, constant: 25),
            moveToStorageBtn.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
            
            dateLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -5),
        ])
        return $0
    }(UIView())
    
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
    
    
    private lazy var descriptionLabel = ViewManager.getLabel("",textColor: .black ,textAligment: .left, font: .systemFont(ofSize: 14), numberOfLines: 10)
    private lazy var dateLabel = ViewManager.getLabel("",textColor: .lightGray,textAligment: .left, font: .systemFont(ofSize: 14))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return $0
    }(UIImageView())
    //MARK: Action elements
    private lazy var moveToStorageAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.moveToStorageBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
}

