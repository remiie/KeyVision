//
//  DoorsResponse.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import Foundation

struct DoorsResponse: Decodable {
    let success: Bool
    let data: [Door]?
}
