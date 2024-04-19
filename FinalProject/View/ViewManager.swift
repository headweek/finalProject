//
//  ViewManager.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import UIKit

final class ViewManager {
    private init() {}
    
    //MARK: Функция добавления кнопки
    static func createBtn(_ title: String, btnColor: UIColor = .signInColor, cornenRadius: CGFloat = 14, textColor: UIColor = .white, action: UIAction, backgroundColor: UIColor = .black) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.layer.cornerRadius = cornenRadius
        btn.backgroundColor = backgroundColor
        return btn
    }
    
    static func backgroundImage (contentMode: UIImageView.ContentMode) -> UIImageView {
        let image: UIImageView = .init(image: .back)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    static func getLabel(_ text: String, textColor: UIColor = .white, textAligment: NSTextAlignment, font: UIFont = .boldSystemFont(ofSize: 18), numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAligment
        label.font = font
        label.numberOfLines = numberOfLines
        return label
    }
    
    static func resizeImage(_ imageName: String, size: CGSize) -> UIImage? {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.frame.size = size
        return imageView.image
    }
    
    static func getLabelForHeader() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        return label
    }
    
    static func getLinkLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }
    
    
}


