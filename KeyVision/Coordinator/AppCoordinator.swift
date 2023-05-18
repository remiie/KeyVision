//
//  AppCoordinator.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class AppCoordinator {
    func start() -> UIViewController {
        let tabBarController = BaseTabBarController()

        let cameraViewController = CameraController()
        cameraViewController.title = "Камеры"
    
        let doorViewController = DoorController()
        doorViewController.title = "Двери"
   
        let viewControllers = [cameraViewController, doorViewController]
        tabBarController.setViewControllers(viewControllers, animated: true)

        return tabBarController
    }
    
}



