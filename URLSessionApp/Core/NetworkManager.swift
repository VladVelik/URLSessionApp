//
//  NetworkManager.swift
//  URLSessionApp
//
//  Created by Sosin Vladislav on 19.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void ) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchImagesInfo(url: String, complition: @escaping([Image]) -> Void) {
        guard let url = URL(string: URLs.postsList) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode([Image].self, from: data)
                complition(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
