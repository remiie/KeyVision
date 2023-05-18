//
//  NetworkManager.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import UIKit
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let cameras: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "cars.cprogroup.ru"
        components.path = "/api/rubetek/cameras/"
        return components
    }()
    
    private let doors: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "cars.cprogroup.ru"
        components.path = "/api/rubetek/doors/"
        return components
    }()
    
}

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
    
    func fetchCameras(completion: @escaping (Result<CamerasResponse, Error>) -> ()) {
        guard let url = cameras.url else { completion(.failure(NetworkError.invalidURL)); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { completion(.failure(NetworkError.invalidData)); return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let card = try decoder.decode(CamerasResponse.self, from: data)
                completion(.success(card))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchDoors(completion: @escaping (Result<DoorsResponse, Error>) -> ()) {
        guard let url = doors.url else { completion(.failure(NetworkError.invalidURL)); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { completion(.failure(NetworkError.invalidData)); return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let card = try decoder.decode(DoorsResponse.self, from: data)
                completion(.success(card))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
}


enum NetworkError: Error {
    case invalidURL
    case invalidData
}
