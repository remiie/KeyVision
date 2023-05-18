//
//  Door.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import Foundation

struct Door: Decodable {
    let name: String?
    let snapshot: String?
    let room: String?
    let id: Int
    let favorites: Bool
    var camera: Bool { (snapshot != nil) }
}
