//
//  Door.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import RealmSwift
import Foundation

class Door: Object, Decodable {
    @objc dynamic var name: String?
    @objc dynamic var snapshot: String?
    @objc dynamic var room: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var favorites: Bool

    var camera: Bool { return snapshot != nil }

    override static func primaryKey() -> String? {
        return "id"
    }
}
