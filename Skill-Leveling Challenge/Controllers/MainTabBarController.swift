//
//  MainTabBarController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 21-09-22.
//

import UIKit

class MainTabBarController: UITabBarController {

        override func viewDidLoad() {
            super.viewDidLoad()

            self.tabBar.barTintColor = .white
            self.tabBar.tintColor = UIColor(named: "MeliBlue")
            self.tabBar.unselectedItemTintColor = .gray
            self.tabBar.layer.borderColor = UIColor.gray.cgColor
            self.tabBar.layer.borderWidth = 0.25

            let homeNavigationController = UINavigationController(rootViewController: HomeViewController())

            let homeViewControllerTabBarItem = UITabBarItem(title: "Inicio", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "House"))

            homeNavigationController.tabBarItem = homeViewControllerTabBarItem
            homeNavigationController.tabBarItem.tag = 0

            let favoritesNavigationController = UINavigationController(rootViewController: FavoritesViewController())
            
            let favoritesViewTabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart"))

            favoritesNavigationController.tabBarItem = favoritesViewTabBarItem
            favoritesNavigationController.tabBarItem.tag = 1
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor(named: "MeliYellow")
            
            let appearance = UINavigationBar.appearance()
            appearance.standardAppearance = navBarAppearance
            appearance.compactAppearance = navBarAppearance
            appearance.scrollEdgeAppearance = navBarAppearance
            if #available(iOS 15.0, *) {
                appearance.compactScrollEdgeAppearance = navBarAppearance
            } else {
                // Fallback on earlier versions
            }

            viewControllers = [homeNavigationController, favoritesNavigationController]

        }

}
