//
//  ViewController.swift
//  FinalProject
//
//  Created by Kazbek and Salman on 30.03.24.
//


import UIKit
import WebKit

class ViewController: UIViewController{
    
    private var webView : WebViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activituView)
        // Добавление кнопки "Вход через VK"
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Вход через VK", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activituView.stopAnimating()
            UIView.animate(withDuration: 0.5) {
                self.activituView.removeFromSuperview()
            }
        }
        
    }
    
    private lazy var loginButton = ViewManager.createBtn("Login", action: action)
    
    private lazy var action = UIAction {[weak self] _ in
        guard let self else { return }
        guard let webView else { return }
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    private lazy var activituView: UIActivityIndicatorView = {
        $0.style = .large
        $0.startAnimating()
        $0.center = view.center
        return $0
    }(UIActivityIndicatorView())
    
    @objc private func loginButtonTapped() {
        // Запуск процесса авторизации VK
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=51892163&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=offline&response_type=token&v=5.199")!
        let webViewController = WebViewController(url: url)
        navigationController?.pushViewController(webViewController, animated: true)
    }

}

