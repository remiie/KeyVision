//
//  ImageLoader.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import UIKit
import Foundation

extension NetworkManager {
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
}
