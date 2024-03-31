//
//  ViewManager.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import UIKit
import WebKit

final class ViewManager {
    //MARK: Функция добавления кнопки
    static func createBtn(_ title: String, btnColor: UIColor = .signInColor, cornenRadius: CGFloat = 14, textColor: UIColor = .white, action: UIAction) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.layer.cornerRadius = cornenRadius
        return btn
    }
    
}


