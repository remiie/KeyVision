//
//  DoorViewController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

final class DoorController: UIViewController {
    
    private lazy var doorsView: DoorsView = {
        let view = DoorsView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var doors = [Door]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        view.addSubview(doorsView)
        
        NSLayoutConstraint.activate([
            doorsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.width/3 + 10),
            doorsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doorsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doorsView.bottomAnchor.constraint(equalTo: view.bottomAnchor) ])
    }
    
    private func loadData() {
        NetworkManager.shared.fetchDoors { [self] result in
            switch result {
            case .success(let successResponse):
                guard successResponse.success,
                      let loadedDoors = successResponse.data else { return }
                doors.append(contentsOf: loadedDoors)
                DispatchQueue.main.async { [self] in
                    doorsView.updateView()
                }
            case .failure(let failureResponse):
                print(failureResponse.localizedDescription) // alert
            }
        }
    }
    
}

extension DoorController: DoorsViewDelegate {
    func getItemsCount() -> Int {
        return doors.count
    }
    
    func getItem(at index: IndexPath) -> Door {
        let door = doors[index.row]
        return door
    }
    func doorHasCamera(at index: IndexPath) -> Bool {
        let camera = doors[index.row].snapshot != nil
        return camera
    }
    
}
