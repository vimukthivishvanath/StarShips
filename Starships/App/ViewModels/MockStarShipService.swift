//
//  MockStarShipService.swift
//  StarshipsTests
//
//  Created by Vimukthi Vishvanath on 10/10/21.
//

import Foundation
@testable import Starships

class MockStarShipService: APIClientProtocol {
    
    var delay: TimeInterval = 0.0
    var data: Result<StarshipModel, APIError>?
    var error: Error?
    var statusCode: Int = 200
    var starshipModel:StarshipModel?
    
    func fetchStarships(with page: Int, completion: @escaping FetchDataCompletion) {
//        let result: FetchDataCompletion?
        //let url = URL(string: "\(APIConfig.manager.baseUrl)")
        //let response = HTTPURLResponse(url: url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        if let starshipModel = starshipModel {
            completion(.success(starshipModel))
        } else {
            completion(.failure(.noData))
        }
    }
    
}

