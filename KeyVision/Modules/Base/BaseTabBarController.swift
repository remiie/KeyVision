//
//  BaseTabBarController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLayoutSubviews() {
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()        
    }
    
    private func configure() {
        tabBar.barTintColor = .white
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hexString: "333333")
        ]
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor(hexString: "333333")
        ]
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)

    }

}


