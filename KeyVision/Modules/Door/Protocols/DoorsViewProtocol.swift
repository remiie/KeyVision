//
//  DoorsViewProtocol.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

protocol DoorsViewProtocol: AnyObject {
    var delegate: DoorsViewDelegate? { get set }
    func updateView()
}

protocol DoorsViewDelegate: AnyObject {
    func getItemsCount() -> Int
    func getItem(at index: IndexPath) -> Door
    func doorHasCamera(at index: IndexPath) -> Bool
}
