//
//  AppCoordinator.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class AppCoordinator {
    func start() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        let cameraViewController = CameraViewController()
        cameraViewController.tabBarItem = UITabBarItem(title: "Камеры", image: nil, tag: 0)
        
        let doorViewController = DoorViewController()
        doorViewController.tabBarItem = UITabBarItem(title: "Двери", image: nil, tag: 1)
        
        tabBarController.viewControllers = [cameraViewController, doorViewController]
        
        return tabBarController
    }
}


