//
//  WebViewController.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 31.03.24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
        var url: URL
        
        init(url: URL) {
            self.url = url
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.load(URLRequest(url: url))
    }
}
