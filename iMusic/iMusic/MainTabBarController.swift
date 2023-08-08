//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Роман on 02.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let searchVC = SearchMusicViewController()
        let libraryVC = ViewController()
        
        let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
        
        viewControllers = [
            generateViewController(rootViewController: searchViewController, image: UIImage(systemName: "magnifyingglass")!, title: "Поиск"),
            generateViewController(rootViewController: libraryVC, image: UIImage(systemName: "book")!, title: "Медиатека")
        ]
        
        func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
            
            rootViewController.title = title
            let navigationVC = UINavigationController(rootViewController: rootViewController)
            
            tabBar.tintColor = .systemPink
            tabBar.unselectedItemTintColor = .systemGray
            tabBar.backgroundColor = .systemGray3
            
            navigationVC.view.backgroundColor = .white
            navigationVC.navigationBar.barStyle = .black
            navigationVC.tabBarItem.image = image
            navigationVC.navigationBar.prefersLargeTitles = true
            
            return navigationVC
        }
    }
}
