//
//  TabBar.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit

final class TabBar: UITabBarController {

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let storageVC = UINavigationController(rootViewController: StorageController())
        storageVC.tabBarItem.title = "Хранилище"
        storageVC.tabBarItem.image = UIImage(systemName: "star.fill")
        let vkVC = UINavigationController(rootViewController: VKController())
        vkVC.tabBarItem.title = "Error Nil Vk"
        vkVC.tabBarItem.image = UIImage(resource: .vkLogo)
        let newsVC = UINavigationController(rootViewController: NewsController())
        newsVC.tabBarItem.title = "Новости"
        newsVC.tabBarItem.image = UIImage(systemName: "star")
        viewControllers = [newsVC, vkVC, storageVC]
    }

}
