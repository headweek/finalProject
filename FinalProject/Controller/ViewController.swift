//
//  ViewController.swift
//  FinalProject
//
//  Created by Kazbek and Salman on 30.03.24.
//


import UIKit

final class ViewController: UIViewController{
    
    private var isFinish = false

    
    
    private var webView = WebViewController()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        settupView()
    }
    
    //MARK: Functions
    private func settupView() {
        view.addSubview(backgroundImage)
        view.addSubview(activituView)
        view.addSubview(loginButton)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activituView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            activituView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    
    //MARK: View elements
    private lazy var loginButton = ViewManager.createBtn("Войти", action: action)
    private lazy var backgroundImage = ViewManager.backgroundImage(contentMode: .scaleAspectFill)
    
    private lazy var titleLabel = ViewManager.getLabel("Error nil", textAligment: .natural)
    
    private lazy var activituView: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.style = .large
        $0.color = .blue
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    //MARK: Action elements
    private lazy var action = UIAction {[weak self] _ in
        guard let self else { return }
        if isFinish {
            self.navigationController?.pushViewController(webView, animated: true)
        } else {
            self.view.layer.add(AnimateManager.getShakingAnimates(shakesView: self.view), forKey: "position")
            print("error")
        }
        
    }
}

extension ViewController: WebViewDelegate {
    func didFinish() {
        activituView.stopAnimating()
        activituView.removeFromSuperview()
        isFinish = true
    }
}
