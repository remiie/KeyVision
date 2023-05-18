//
//  CameraViewController.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

class CameraController: UIViewController {
    
    private lazy var camerasView: CamerasView = {
        let view = CamerasView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var rooms = [String]()
    private var cameras = [Camera]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
        
    }
    
    
    private func configure() {
        view.addSubview(camerasView)
        view.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([ // save constant
            camerasView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.width/4 + 10),
            camerasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            camerasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            camerasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func loadData() {
        NetworkManager.shared.fetchCameras { [self] result in
            switch result {
            case .success(let successResponse):
                guard successResponse.success,
                      let loadedCameras = successResponse.data.cameras,
                      let loadedRooms = successResponse.data.room else { return }
                DispatchQueue.main.async { [self] in
                    camerasView.updateView()
                }
                rooms.append(contentsOf: loadedRooms)
                cameras.append(contentsOf: loadedCameras)
            case .failure(let failureResponse):
                print(failureResponse.localizedDescription) // alert controller
            }
        }
    }
    

}

// MARK: - TableView Delegate

extension CameraController: CamerasViewDelegate {
        
    func getSectionCount() -> Int {
        return rooms.count + 1
    }
    
    func getSectionTitle(for section: Int) -> String {
        if section == rooms.count { return "OTHERS"}
        guard rooms.count > 0 else { return "" }
        return rooms[section]
    }
    
    func getItemsCount(for section: Int) -> Int {
        if section == rooms.count {
            let count = cameras.filter { $0.room == nil }.count
            return count
        }
        let count = cameras.filter { $0.room == rooms[section] }.count
        return count

    }
    
    func getItem(for index: IndexPath) -> Camera {
        if index.section == rooms.count {
            let nullSection = cameras.filter { $0.room == nil }
            return nullSection[index.row]
        }
        let camerasForSection = cameras.filter { $0.room == rooms[index.section] }
        return camerasForSection[index.row]
    }
    
    
}

