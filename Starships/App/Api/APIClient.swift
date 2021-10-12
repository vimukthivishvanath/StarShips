//
//  NetworkManager.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 8/10/21.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case noData
    case responseUnsuccessful
    case jsonParsingFailure
    case unexpectedError
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .unexpectedError: return "Unexpected Error"
        case .invalidData: return "Invalid Data"
        case .noData: return "No Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClientProtocol {
    
    typealias FetchDataCompletion = (Result<StarshipModel, APIError>) -> ()
    
    func fetchStarships(with page:Int,completion: @escaping FetchDataCompletion)
    
}

class APIClient : APIClientProtocol {
    
    private lazy var baseURL: URL = {
        return URL(string: "https://swapi.dev/api/starships/")!
    }()
    
    func fetchStarships(with page:Int, completion: @escaping FetchDataCompletion) {
        let customizeURLString = "\(baseURL)?page=\(page)"
        let url = URL(string: customizeURLString)!
        let request = URLRequest(url:url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 120)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            //Check status code
            if (200 ... 299).contains(httpResponse.statusCode) {
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                if let _ = error {
                    completion(.failure(.unexpectedError))
                    return
                }
                do {
                    let starshipModel = try JSONDecoder().decode(StarshipModel.self, from: data)
                    completion(.success(starshipModel))
                } catch _ {
                    completion(.failure(.jsonConversionFailure))
                }
            }else{
                completion(.failure(.responseUnsuccessful))
                return
            }
            
        }.resume()
    }
    
}

