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
    
    lazy var titleLabel: UILabel = {
        $0.text = "Error Nil"
        $0.textColor = .white
        $0.textAlignment = .natural
        return $0
    }(UILabel(frame: .init(x: 20, y: 20, width: 20, height: 20)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(backgroundImage)
        view.addSubview(activituView)
        
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Добавление кнопки "Вход через VK"
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.tintColor = .white
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 30
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activituView.stopAnimating()
            UIView.animate(withDuration: 0.5) {
                self.activituView.removeFromSuperview()
            }
        }
        view.addSubview(titleLabel)
    }
    
    private lazy var loginButton = ViewManager.createBtn("Login", action: action)
    private lazy var backgroundImage = ViewManager.backgroundImage(contentMode: .scaleAspectFill)
    
    
    
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

