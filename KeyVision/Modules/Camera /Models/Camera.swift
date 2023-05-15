//
//  Camera.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import Foundation
typealias Room = [String]

struct Camera {
    let name: String?
    let snapshot: String?
    let room: String?
    let id: Int
    let favorites: Bool
    let rec: Bool
}
