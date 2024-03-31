//
//  WebKit.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import Foundation
import WebKit

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
        }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url,
           url.absoluteString.hasPrefix("https://oauth.vk.com/blank.html"),
           let fragment = url.fragment {
            // Парсинг
            let parameters = fragment.components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce(into: [String: String]()) { result, pair in
                    guard pair.count == 2 else { return }
                    let key = pair[0], value = pair[1]
                    result[key] = value
                }
            if let accessToken = parameters["access_token"], let userId = parameters["user_id"] {
                // успешно
                print("User authorized: \(userId)")
                print("Access Token: \(accessToken)")
                let resultVC = ResultViewController()
                navigationController?.pushViewController(resultVC, animated: true)
            } else if let error = parameters["error"] {
                // Ошибка
                print("Authorization error: \(error)")
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}
