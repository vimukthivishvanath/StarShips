//
//  StarshipListViewModel.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import Foundation

protocol StarshipViewModelDelegate: AnyObject {
    func onFetchCompleted()
    func onFetchFailed(with errorMessage: String)
}

class StarshipListViewModel: NSObject{
    
    weak var delegate: StarshipViewModelDelegate?
    private var apiClient: APIClientProtocol
    var starshipArray = [Starship]()
    private var currentPage = 1
    private var total = 0
    var isFetchInProgress = false
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    var currentCount: Int {
        return starshipArray.count
    }
    
    var totalCount: Int {
        return total
    }
    
    func starship(at index: Int) -> Starship {
        return starshipArray[index]
    }
    
    func sortArrayToAscendingOrder(starships:[Starship]) -> [Starship]{
        let sortedArray = starships.sorted{ $0.name! < $1.name!}
        return sortedArray
    }
    
    func getStarships() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        apiClient.fetchStarships(with: currentPage) { (result) in
            switch result{
            case .failure(let error):
                self.isFetchInProgress = false
                print("Error occured: \(error)")
                self.delegate?.onFetchFailed(with: error.localizedDescription)
                
            case .success(let starshipModel):
                self.currentPage += 1
                self.isFetchInProgress = false
                self.total = starshipModel.count ?? 0
                let starships = starshipModel.results ?? []
                //Sort each page starship data to ascending order by it's name
                let sortedStarShipList = self.sortArrayToAscendingOrder(starships: starships)
                
                self.starshipArray.append(contentsOf: sortedStarShipList)
                
                if starshipModel.next != nil {
                    self.delegate?.onFetchCompleted()
                } else {
                    self.delegate?.onFetchCompleted()
                }
            }
        }
        
        
    }
    
    
}
