//
//  DatabaseManager.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func cacheCameras(_ cameras: [Camera]) {
        print("cache cameras")
        do {
            try realm.write {
                realm.add(cameras, update: .modified)
            }
        } catch {
            print("Failed to cache cameras: \(error)")
        }
    }
    
    func cacheDoors(_ doors: [Door]) {
        print("cache Doors")
        do {
            try realm.write {
                realm.add(doors, update: .modified)
            }
        } catch {
            print("Failed to cache doors: \(error)")
        }
    }
    
    func getCachedCameras() -> [Camera]? {
        print("get from DB")
        let cameras = realm.objects(Camera.self)
        return Array(cameras)
    }
    
    
    func getCachedDoors() -> [Door]? {
        print("get from DB")
        let doors = realm.objects(Door.self)
        return Array(doors)
    }
    
    func clearDatabase() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to clear database: \(error)")
        }
    }
    
    func changeCameraFavorites(for cameraID: Int) {
        do {
            let realm = try Realm()
            guard let camera = realm.object(ofType: Camera.self, forPrimaryKey: cameraID) else {
                print("Camera not found")
                return
            }
            
            try realm.write {
                camera.favorites = camera.favorites ? false : true
            }
        } catch {
            print("Failed to write to Realm: \(error)")
        }
    }
    
    func changeDoorFavorites(for doorID: Int) {
        do {
            let realm = try Realm()
            guard let door = realm.object(ofType: Door.self, forPrimaryKey: doorID) else {
                print("Door not found")
                return
            }
            
            try realm.write {
                print("changeDoorFavorites")
                door.favorites = door.favorites ? false : true
            }
        } catch {
            print("Failed to write to Realm: \(error)")
        }
    }
    
    func changeDoorName(for doorID: Int, name: String) {
        do {
            let realm = try Realm()
            guard let door = realm.object(ofType: Door.self, forPrimaryKey: doorID) else {
                print("Door not found")
                return
            }
            
            try realm.write {
                door.name = name
            }
        } catch {
            print("Failed to write to Realm: \(error)")
        }
    }
    
}

