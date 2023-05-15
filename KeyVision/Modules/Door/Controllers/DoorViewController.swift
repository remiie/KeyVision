//
//  DoorViewController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

final class DoorViewController: UIViewController {
    
    private lazy var doorsView: DoorsView = {
        let view = DoorsView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        view.addSubview(doorsView)
        
        NSLayoutConstraint.activate([
            doorsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.width/4 + 10),
            doorsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doorsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doorsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension DoorViewController: DoorsViewDelegate {
    func getItemsCount() -> Int {
        return 4
    }
    
    func getItem(at index: IndexPath) -> Door {
        return Door(name: "door", snapshot: nil, room: nil, id: 1, favorites: true)
    }
    func doorHasCamera(at index: IndexPath) -> Bool {
        return true
    }
    
}
