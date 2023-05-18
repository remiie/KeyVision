//
//  CamerasResponse.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import Foundation

struct CamerasResponse: Decodable {
    let success: Bool
    let data: CamerasData
    
    struct CamerasData: Decodable {
        let room: [String]?
        let cameras: [Camera]?
    }
}
