//
//  Camera.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import RealmSwift
import Foundation

class Camera: Object, Decodable {
    @objc dynamic var name: String?
    @objc dynamic var snapshot: String?
    @objc dynamic var room: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var favorites: Bool
    @objc dynamic var rec: Bool

    override static func primaryKey() -> String? {
        return "id"
    }
}
