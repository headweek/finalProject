//
//  Color + String.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import UIKit

extension UIColor {
    static let signInColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    static let viewColor = UIColor.white
}

extension String {
    static let accessToken = "access_token"
    static let lustSearch = "lustSearch"
}

extension String {
    var toHost: String? {
        guard let encodeUrl = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let components = URLComponents(string: encodeUrl) else { return nil }
        return "\(components.scheme ?? "")://\(components.host ?? "")"
    }
}
