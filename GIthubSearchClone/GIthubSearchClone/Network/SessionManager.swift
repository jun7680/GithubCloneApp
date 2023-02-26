//
//  SessionManager.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case notResponse
    case invalidParam
    case decodingError
}

class SessionManager {
    static let shared = SessionManager()
    private let session = URLSession.shared
    
    func request<T: Codable>(type: APIType) -> Single<T> {
        guard let components = self.urlComponents(apiType: type),
              let url = components.url
        else {
            return .error(NetworkError.invalidParam)
        }
        
        return Single.create { [weak self] single in
            self?.session.dataTask(with: url) { data, response, error in
                do {
                    let successRange = 200..<300
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    
                    if !successRange.contains(statusCode), let error = error {
                        throw error
                    }
                    
                    guard let data else { throw NetworkError.notResponse }
                    
                    let model: T = try JSONDecoder().decode(T.self, from: data)
                    single(.success(model))
                } catch {
                    print(error)
                    single(.failure(NetworkError.decodingError))
                }
            }.resume()
            
            return Disposables.create {}
        }
    }
    
    private func urlComponents(apiType: APIType) -> URLComponents? {
        var url = apiType.baseURL.appendingPathComponent(apiType.path).absoluteString
        
        let queryItems = apiType.params.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        if !queryItems.isEmpty {
            url += "?"
        }
        
        var components = URLComponents(string: url)
        components?.queryItems?.append(contentsOf: queryItems)
        
        return components
    }
}
