//
//  Endpoint.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import Foundation

enum Endpoint {
    case cameras
    case doors
    
    var path: String {
        switch self {
        case .cameras:
            return "/api/rubetek/cameras/"
        case .doors:
            return "/api/rubetek/doors/"
        }
    }
}
