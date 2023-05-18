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
        loadDataFromDatabase()
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
        
        NetworkManager.shared.fetchData(from: .doors) { [self] (result: Result<DoorsResponse, Error>) in
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
    
    
    private func loadDataFromDatabase() {
        DispatchQueue.main.async { [weak self] in
            if let cachedDoors = DatabaseManager.shared.getCachedDoors(), !cachedDoors.isEmpty {
                self?.handleDoorsData(cachedDoors)
            } else {
                self?.loadDataFromServer()
            }
        }
    }
    

    
    func loadDataFromServer() {
        NetworkManager.shared.fetchData(from: .doors) { [self] (result: Result<DoorsResponse, Error>) in
            switch result {
            case .success(let successResponse):
                guard successResponse.success,
                      let doors = successResponse.data else { return }
                handleDoorsData(doors)
                DispatchQueue.main.async {
                    DatabaseManager.shared.cacheDoors(doors)
                }
               
            case .failure(let failureResponse):
                print("Error loading cameras: \(failureResponse.localizedDescription)") // alert controller
                
            }
        }
    
    }
    
    private func handleDoorsData(_ doors: [Door]) {
        self.doors = doors
        DispatchQueue.main.async { [weak self] in
            self?.doorsView.updateView()
            self?.doorsView.endRefreshing()
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
// MARK: - FAVORITE & EDIT

extension DoorController {
    func changeFavorites(for index: Int) {
        let door = doors[index]
        DatabaseManager.shared.changeDoorFavorites(for: door.id)
        doorsView.updateView()
        
    }
    
    func presentEdit(for index: Int) {
        let door = doors[index]
        let alertController = UIAlertController(title: "Изменить название", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите новое название"
        }
            
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            if let text = alertController.textFields?.first?.text {
                DatabaseManager.shared.changeDoorName(for: door.id, name: text)
                    self?.doorsView.updateView()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
}

