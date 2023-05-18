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
        
        NetworkManager.shared.fetchData(from: .cameras) { [self] (result: Result<CamerasResponse, Error>) in
            switch result {
            case .success(let successResponse):
                guard successResponse.success,
                      let cameras = successResponse.data.cameras,
                      let rooms = successResponse.data.room else { return }

                sections = rooms.filter { room in
                    cameras.contains { $0.room == room }
                }

                camerasBySection = Dictionary(grouping: cameras, by: { $0.room ?? "OTHERS" })

                sections.append("OTHERS")

                sections.sort { $0 < $1 }

                if let othersSectionIndex = sections.firstIndex(of: "OTHERS") {
                    sections.remove(at: othersSectionIndex)
                    sections.insert("OTHERS", at: 0)
                }
                DispatchQueue.main.async { [self] in
                    camerasView.updateView()
                }
                
            case .failure(let failureResponse):
                print(failureResponse.localizedDescription) // alert controller
                
            }
        }
    
    }
    

}

// MARK: - TableView Delegate

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
        
        if var camerasInSection = camerasBySection[sectionKey] {
            var camera = camerasInSection[index.row]
            camera.favorites = camera.favorites ? false : true
            camerasInSection[index.row] = camera
            camerasBySection[sectionKey] = camerasInSection
            camerasView.updateView()
        }
    }
}
