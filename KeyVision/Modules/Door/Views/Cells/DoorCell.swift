//
//  DoorCell.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

final class DoorCell: UITableViewCell {
    
    static let identifier: String = "DoorCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "favorite")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lockButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "lock"), for: .normal)
        button.setImage(UIImage(named: "unlock"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let doorTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25))
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(doorTitle)
        containerView.addSubview(lockButton)
        containerView.addSubview(favoriteImage)
        
        lockButton.addTarget(self, action: #selector(lockButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            doorTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            doorTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            doorTitle.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
        
            lockButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lockButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            favoriteImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            favoriteImage.trailingAnchor.constraint(equalTo: lockButton.leadingAnchor, constant: -6)

        ])
    }
    
    func configure(title: String, favorite: Bool) {
        doorTitle.text = title
        favoriteImage.isHidden = !favorite
    }
    
    @objc func lockButtonPressed(_ sender: UIButton) {
        lockButton.isSelected = lockButton.isSelected ? false : true
    }
    
    
}
