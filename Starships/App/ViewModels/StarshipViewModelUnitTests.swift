//
//  StarshipViewModelUnitTests.swift
//  StarshipsTests
//
//  Created by Vimukthi Vishvanath on 10/10/21.
//

import XCTest
import Mockingjay
@testable import Starships

class StarshipViewModelUnitTests: XCTestCase {
    private let jsonFile = "StarshipMockResponse"
    private let starshipsCount = 10
    private let timeout = 3.0
    
    // MARK: - Properties
    var viewModel: StarshipListViewModel!
    var starshipService: MockStarShipService!

    // MARK: - Set Up & Tear Down
    override func setUp() {
        super.setUp()
        
        // Initialize Mock Starship Service
        starshipService = MockStarShipService()
        
        // Initialize Root View Model
        viewModel = StarshipListViewModel(apiClient: starshipService)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_CheckFetchedStarShipsCount() {
        // Load Stub
        let data = loadStub(name: jsonFile, extension: "json")
        
        // Define Stub
        stub(everything, jsonData(data))

        // Define Expectation
        let expectation = XCTestExpectation(description: "Full Response Returned")

        starshipService.fetchStarships(with: 1) { (result) in
            if case .success(let starshipResponse) = result {
                print(starshipResponse.count ?? 0)
                XCTAssertEqual(starshipResponse.count, self.starshipsCount)

                // Fulfill Expectation
                expectation.fulfill()
            }
        }
    }
    func test_FailedToFetchStarShips() {
        // Configure Location Service
        starshipService.starshipModel = StarshipModel()
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "No Starship data")
        
        // Install Handler
        starshipService.fetchStarships(with: 1, completion: { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, APIError.noData)

                // Fulfill Expectation
                expectation.fulfill()
            }
        })
        
        // Wait for Expectation to Be Fulfilled
        // wait(for: [expectation], timeout: timeout)
    }
    
    func test_FailedToFetchStarShipsData_NoErrorNoResponse() {
        // Define Stub
        stub(everything) { (request) -> (Response) in
            // Create HTTP URL Response
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
            return .success(response, .noContent)
        }
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "NoError or NoResponse For Fetch StarShip Data")
        
        // Install Handler
        starshipService.fetchStarships(with: 1, completion: { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, APIError.noData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        })
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: timeout)
    }
    
    func test_FailedToFetchStarShipsData_RequestFailed() {
        // Create Error
        let error = NSError(domain: "com.sample.network", code: 1, userInfo: nil)
        
        // Define Stub
        stub(everything, failure(error))

        // Define Expectation
        let expectation = XCTestExpectation(description: "Request Failed: Fetch Starship Data")
        
        // Install Handler
        starshipService.fetchStarships(with: 1, completion: { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, APIError.noData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        })
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: timeout)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
