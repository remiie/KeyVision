//
//  BaseTabBarController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var titleLabel = UILabel()
    
    override func viewDidLayoutSubviews() {
        let labelY = titleLabel.frame.origin.y
        tabBar.frame = CGRect(x: 0, y: labelY + 40, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()        
    }
    
    private func configure() {
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Мой дом"
        
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(hexString: "333333")
        titleLabel.font = UIFont(name: "Avenir Next Medium", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .medium)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        tabBar.barTintColor = .systemGray6
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
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


