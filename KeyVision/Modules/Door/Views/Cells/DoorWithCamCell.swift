//
//  DoorWithCamCell.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

final class DoorWithCamCell: UITableViewCell {
    
    static let identifier: String = "DoorWithCamCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doorStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
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
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(cameraImage)
        containerView.addSubview(doorTitle)
        containerView.addSubview(doorStatus)
        containerView.addSubview(lockButton)
        cameraImage.addSubview(favoriteImage)
        containerView.addSubview(activityIndicator)
        lockButton.addTarget(self, action: #selector(lockButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cameraImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            cameraImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cameraImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            doorTitle.topAnchor.constraint(equalTo: cameraImage.bottomAnchor),
            doorTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            doorTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            doorTitle.heightAnchor.constraint(equalToConstant: 40),
            
            doorStatus.leadingAnchor.constraint(equalTo: doorTitle.leadingAnchor),
            doorStatus.trailingAnchor.constraint(equalTo: doorTitle.trailingAnchor),
            doorStatus.topAnchor.constraint(equalTo: doorTitle.bottomAnchor, constant: 0),
            doorStatus.heightAnchor.constraint(equalToConstant: 20),
            doorStatus.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            lockButton.centerYAnchor.constraint(equalTo: doorStatus.topAnchor),
            lockButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            favoriteImage.topAnchor.constraint(equalTo: cameraImage.topAnchor, constant: 6),
            favoriteImage.trailingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: -6),
            
            activityIndicator.centerXAnchor.constraint(equalTo: cameraImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: cameraImage.centerYAnchor)
            
        ])
    }
    
    func configure(with image: String?, title: String?, status: String?, favorite: Bool) {
        activityIndicator.startAnimating()
        doorTitle.text = title
        favoriteImage.isHidden = !favorite
        doorStatus.text = status
        loadImage(image)
    }
    
    @objc func lockButtonPressed(_ sender: UIButton) {
        lockButton.isSelected = lockButton.isSelected ? false : true
    }
    
    private func loadImage(_ urlString: String?) {
        guard urlString != nil, let url = URL(string: urlString!) else { return }
        NetworkManager.shared.downloadImage(url: url) { image in
            DispatchQueue.main.async { [self] in
                activityIndicator.stopAnimating()
                cameraImage.image = image
            }
        }
    }
    
}

