//
//  CameraViewController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class CameraViewController: UIViewController {
    
    private lazy var camerasView: CamerasView = {
        let view = CamerasView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        view.addSubview(camerasView)
        view.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            camerasView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.width/4 + 10),
            camerasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            camerasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            camerasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}

// MARK: - TableView Delegate

extension CameraViewController: CamerasViewDelegate {
    func getSectionCount() -> Int {
        return 1
    }
    
    func getSectionTitle(for index: IndexPath) -> String {
        return "title"
    }
    
    func getItemsCount(for section: Int) -> Int {
        return 2
    }
    
    func getItem(for index: IndexPath) -> Camera {
        return Camera(name: "camera", snapshot: nil, room: nil, id: 1, favorites: false, rec: false)
    }
    
    
}

