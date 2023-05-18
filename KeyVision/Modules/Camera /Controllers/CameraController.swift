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
        
    private var sections: [String] = []
    private var camerasBySection: [String: [Camera]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadDataFromDatabase()
    }
    
    private func configure() {
        view.addSubview(camerasView)
        view.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            camerasView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.width/3 + 10),
            camerasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            camerasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            camerasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func loadDataFromDatabase() {
        DispatchQueue.main.async { [weak self] in
            if let cachedCameras = DatabaseManager.shared.getCachedCameras(), !cachedCameras.isEmpty {
                self?.handleCamerasData(cachedCameras)
            } else {
                self?.loadDataFromServer()
            }
        }
    }

    
     func loadDataFromServer() {
        NetworkManager.shared.fetchData(from: .cameras) { [self] (result: Result<CamerasResponse, Error>) in
            switch result {
            case .success(let successResponse):
                guard successResponse.success,
                      let cameras = successResponse.data.cameras else { return }
                handleCamerasData(cameras)
                DispatchQueue.main.async {
                    DatabaseManager.shared.cacheCameras(cameras)
                }
               
            case .failure(let failureResponse):
                print("Error loading cameras: \(failureResponse.localizedDescription)") // alert controller
                
            }
        }
    
    }
    
    @objc private func refreshData() {
        loadDataFromServer()
    }
    
    private func handleCamerasData(_ cameras: [Camera]) {
        let rooms = cameras.compactMap { $0.room }
        let uniqueRooms = Array(Set(rooms))
        
        sections = uniqueRooms.filter { room in
            cameras.contains { $0.room == room }
        }
        
        camerasBySection = Dictionary(grouping: cameras, by: { $0.room ?? "OTHERS" })
        
        sections.append("OTHERS")
        
        sections.sort { $0 < $1 }
        
        if let othersSectionIndex = sections.firstIndex(of: "OTHERS") {
            sections.remove(at: othersSectionIndex)
            sections.insert("OTHERS", at: 0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.camerasView.updateView()
            self?.camerasView.endRefreshing()
        }
    }
}

// MARK: - CamerasViewDelegate

extension CameraController: CamerasViewDelegate {
    func getSectionCount() -> Int {
        return sections.count
    }
    
    func getSectionTitle(for section: Int) -> String {
        return sections[section]
    }
    
    func getItemsCount(for section: Int) -> Int {
        let sectionKey = sections[section]
        return camerasBySection[sectionKey]?.count ?? 0
    }
    
    func getItem(for index: IndexPath) -> Camera? {
        let sectionKey = sections[index.section]
        if let camerasInSection = camerasBySection[sectionKey] {
            return camerasInSection[index.row]
        }
        return nil
    }
    
    
    func changeFavorites(for index: IndexPath) {
        let sectionKey = sections[index.section]
        
        if let camerasInSection = camerasBySection[sectionKey] {
            let camera = camerasInSection[index.row]
            
            DatabaseManager.shared.changeCameraFavorites(for: camera.id)
            camerasView.updateView()
        }
    }



    
    
    
}
