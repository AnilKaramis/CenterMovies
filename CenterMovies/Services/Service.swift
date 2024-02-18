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
    static let API_KEY = "https://api.themoviedb.org/3/trending/movie/day?api_key=af067a44d06ee3786eb8c2581fd911ff"
    static let baseURL = "https://api.themoviedb.org"
    static let imageAddress = "https://image.tmdb.org/t/p/original/"
}

// MARK: - Enums
enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    static func getCenterMovies(completion: @escaping (Result<MoviesModel, Error>) -> Void) {
        
        let task  = URLSession.shared.dataTask(with: URLRequest(url: getFullURL())) {
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
