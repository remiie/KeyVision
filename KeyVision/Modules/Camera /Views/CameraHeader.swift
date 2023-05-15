//
//  CameraHeaderView.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

class CameraHeaderView: UIView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(hexString: "333333")
        titleLabel.font = UIFont(name: "Avenir Next", size: 20) ?? UIFont.systemFont(ofSize: 22, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        let padding: CGFloat = 30
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

