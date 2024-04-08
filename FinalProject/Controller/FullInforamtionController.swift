//
//  FullInforamtionController.swift
//  FinalProject
//
//  Created by apple on 08.04.2024.
//

import UIKit

final class FullInforamtionController: UIViewController {

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
    }
    

    //MARK: Functions
    private func settupView() {
        view.backgroundColor = .viewColor
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configView(image: UIImage, data: ItemData) {
        self.image.image = image
        self.authorLabel.text = data.author
        self.dateLabel.text = data.date
        self.linkLabel.text = data.link
        self.titleLabel.text = data.title
        self.contentLabel.text = data.description
    }
    //MARK: View elements
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        $0.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: $0.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: $0.widthAnchor),
        ])
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(image)
        $0.addSubview(authorLabel)
        $0.addSubview(dateLabel)
        $0.addSubview(linkLabel)
        $0.addSubview(titleLabel)
        $0.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            image.topAnchor.constraint(equalTo: $0.topAnchor),
            image.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            authorLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 10),
            authorLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -10),
            
            dateLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            
            linkLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 10),
            linkLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            linkLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 10),
            
            contentLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -10),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -50),
        ])
        
        return $0
    }(UIView())
    
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var authorLabel = ViewManager.getLabel("Автор : ",textColor: .black ,textAligment: .left, font: .boldSystemFont(ofSize: 16))
    private lazy var dateLabel = ViewManager.getLabel("Дата публикации : ",textColor: .lightGray ,textAligment: .left, font: .systemFont(ofSize: 14))
    private lazy var linkLabel = ViewManager.getLabel("Ссылка : ",textColor: .black ,textAligment: .left, font: .boldSystemFont(ofSize: 14))
    private lazy var titleLabel = ViewManager.getLabel("Заголовок : ",textColor: .black ,textAligment: .left, font: .boldSystemFont(ofSize: 20))
    private lazy var contentLabel = ViewManager.getLabel("Статья : ",textColor: .black ,textAligment: .center, font: .systemFont(ofSize: 16))
    
    //MARK: Aciton elements

}
