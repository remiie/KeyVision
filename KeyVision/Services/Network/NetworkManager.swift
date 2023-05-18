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
    
    private let baseURL: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "cars.cprogroup.ru"
        return components
    }()
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = baseURL.url?.appendingPathComponent(endpoint.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseData = try decoder.decode(T.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
