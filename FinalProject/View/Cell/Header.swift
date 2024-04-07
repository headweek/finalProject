//
//  Header.swift
//  FinalProject
//
//  Created by apple on 07.04.2024.
//

import UIKit

final class Header: UICollectionReusableView {
    static let reuseId = "Header"
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    private lazy var label = ViewManager.getLabelForHeader()
    
    //MARK: Functions
    func configCell(_ text: String) {
        label.text = text
    }
    
    private func settupCell() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 25),
        ])
    }
    
    
}
