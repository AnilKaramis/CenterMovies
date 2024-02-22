//
//  Service.swift
//  CenterMovies
//
//  Created by AnılKaramış on 11.02.2024.
//

import Foundation
import UIKit
// MARK: - API
struct NetworkConstant {
    static let API_KEY2 = "af067a44d06ee3786eb8c2581fd911ff"
    static let API_KEY = "https://api.themoviedb.org/3/trending/movie/day?api_key=af067a44d06ee3786eb8c2581fd911ff"
    static let baseURL = "https://api.themoviedb.org"
    static let imageAddress = "https://image.tmdb.org/t/p/original/"
    static let imageBaseURL = "https://image.tmdb.org/"
    static let imagePath = "/t/p/original/"
}

// MARK: - Enums
enum APIError: Error {
    case failedToGetData
}

enum Endpoint {
    case centerMovies(page: Int)
    case movieDetail
    case imageAddress
    
    var baseURL: URL {
        switch self {
        case .imageAddress:
            return URL(string: NetworkConstant.imageBaseURL)!
        default:
            return URL(string: NetworkConstant.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .centerMovies, .movieDetail:
            return "/3/trending/movie/day"
        case .imageAddress:
            return NetworkConstant.imagePath
        }
    }
    
    var queryParameters: [String: Any] {
        
        var params: [String: Any] = [
            "api_key": NetworkConstant.API_KEY2
        ]
        switch self {
        case let .centerMovies(page):
            params["page"] = page
        default:
            break
        }
        
        return params
    }
    
    func buildRequest() -> URLRequest {
        var urlComponents = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path = self.path
        
        var queryItems: [URLQueryItem] = []
        for (key, value) in self.queryParameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        
        return URLRequest(url: urlComponents.url!)
    }
}

class APICaller {
    
    static let shared = APICaller()
    
    static func getCenterMovies(page: Int = 2, completion: @escaping (Result<MoviesModel, Error>) -> Void) {
        
        let endpoint = Endpoint.centerMovies(page: page)
        
        let task  = URLSession.shared.dataTask(with: endpoint.buildRequest()) {
            data, response, error in
            guard let data = data, error == nil else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesModel.self , from: data)
                print(results)
                completion(.success(results))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getFullURL() -> URL {
        guard let url = URL(string: "\(NetworkConstant.API_KEY)") else {
            return URL(string: NetworkConstant.baseURL)!}
        return url
    }
}
