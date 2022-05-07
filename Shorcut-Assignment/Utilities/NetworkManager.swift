//
//  NetworkManager.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

final class SimpleNetworkManager {
    static var shared: SimpleNetworkManager = SimpleNetworkManager()
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        // Do futhermore configutation here
        let session = URLSession(configuration: config)
        return session
    }()
    private init() {}
    
    func fireRequest<T: Decodable>(
        _ urlString: String,
        responseType: T.Type,
        completion: @escaping ((Result<T, NetworkError>) -> Void)
    ) {
        guard let url = URL(string: urlString)
        else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.failedDecoding))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.failedRequest))
                }
            }
        }
        dataTask.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case failedRequest
    case failedDecoding
}

extension NetworkError {
    var errorReason: String {
        switch self {
        case .failedDecoding: return "Decoding issue :("
        case .invalidURL: return "Wrong url :("
        case .failedRequest: return "Request failed :("
        }
    }
}
