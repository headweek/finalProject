//
//  VkCell.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import UIKit

final class Cell: UICollectionViewCell {
    
    static let reuseId = "VkCell"
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    private func settupCell() {
        
        backgroundColor = .clear
        layer.cornerRadius = 20
        clipsToBounds = true
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 250),
            
        ])
        
    }
    
    func configCell(_ data: ItemData) {
        image.image = UIImage(named: data.image)
        if let link = data.link {
            self.linkLabel.text = link
            addSubview(linkLabel)
            NSLayoutConstraint.activate([
                linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                linkLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10),
                linkLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ])
        }
        if let title = data.title {
            self.titleLabel.text = title
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                titleLabel.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 10),
            ])
        }
        if let description = data.description {
            self.descriptionLabel.text = description
            addSubview(descriptionLabel)
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            ])
        }
    }
    
    //MARK: View
    private lazy var linkLabel = ViewManager.getLinkLabel()
    private lazy var titleLabel = ViewManager.getLabel("",textColor: .black, textAligment: .left, font: .boldSystemFont(ofSize: 20))
    private lazy var descriptionLabel = ViewManager.getLabel("",textColor: .black ,textAligment: .left, font: .systemFont(ofSize: 14))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    //MARK: Action
    
}
