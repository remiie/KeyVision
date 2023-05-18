//
//  CamerasViewProtocol.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

protocol CamerasViewProtocol: AnyObject {
    var delegate: CamerasViewDelegate? { get set }
    func updateView()
}

protocol CamerasViewDelegate: AnyObject {
    func getSectionCount() -> Int
    func getSectionTitle(for section: Int) -> String
    func getItemsCount(for section: Int) -> Int
    func getItem(for index: IndexPath) -> Camera
}
