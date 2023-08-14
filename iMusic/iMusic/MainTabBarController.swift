//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Роман on 02.08.2023.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailController()
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    private var minimizedTopAnhorConstraint: NSLayoutConstraint!
    private var maximizedTopAnhorConstraint: NSLayoutConstraint!
    private var bottomAnhorConstraint: NSLayoutConstraint!
    let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let libraryVC = ViewController()
        
        setupTrackDetailView()
        
        searchViewController.tabBarDelegate = self
        
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
    
    private func setupTrackDetailView() {
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.backgroundColor = .systemBackground
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchViewController
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        maximizedTopAnhorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnhorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor,
                                                                           constant: -64)
        bottomAnhorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                        constant: view.frame.height)
        bottomAnhorConstraint.isActive = true
        maximizedTopAnhorConstraint.isActive = true
        
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
        
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        maximizedTopAnhorConstraint.isActive = true
        minimizedTopAnhorConstraint.isActive = false
        maximizedTopAnhorConstraint.constant = 0
        bottomAnhorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                                     self.view.layoutIfNeeded()
                                     self.tabBar.alpha = 0
                                   },
                       completion:nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
        
    }
    
    func minimizeTrackDetailController() {
        maximizedTopAnhorConstraint.isActive = false
        bottomAnhorConstraint.constant = view.frame.height
        minimizedTopAnhorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                                     self.view.layoutIfNeeded()
                                     self.tabBar.alpha = 1
                                   },
                       completion:nil)
    }
}
