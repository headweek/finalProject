//
//  WebViewController.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    weak var delegate: WebViewDelegate?
    
    var webView: WKWebView!
        
    init() {
        super.init(nibName: nil, bundle: nil)
        setupWebView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        if let req = VKService.getAuthRequest() {
            webView.load(req)
        }
    }
}

protocol WebViewDelegate: AnyObject {
    func didFinish()
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate?.didFinish()
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
                UserDefaults.standard.setValue(accessToken, forKey: "access_token")
                NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil, userInfo: ["isLogin" : true])
                
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
