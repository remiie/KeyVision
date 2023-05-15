//
//  CameraCell.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

final class CameraCell: UITableViewCell {
    
    static let identifier: String = "CameraCell"
    
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
    
    private let cameraTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.darkGray
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25))
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(cameraImage)
        containerView.addSubview(cameraTitle)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cameraImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            cameraImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cameraImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            cameraTitle.topAnchor.constraint(equalTo: cameraImage.bottomAnchor),
            cameraTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            cameraTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            cameraTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cameraTitle.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    func configure(with image: UIImage?, title: String) {
        cameraImage.image = image
        cameraTitle.text = title
    }
}
