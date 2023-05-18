//
//  NetworkManager.swift
//  KeyVision
//
//  Created by Роман Васильев on 18.05.2023.
//

import Foundation

final class NetworkManager {

    private let cameras: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "cars.cprogroup.ru"
        components.path = "/api/rubetek/cameras/"
        return components
    }()
    
}

extension NetworkManager {
    
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
}


enum NetworkError: Error {
    case invalidURL
    case invalidData
}
