//
//  ShipListCellViewModel.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import Foundation



struct StarshipListCellViewModel{
    let name: String?
    let length: String?
    let rating: String?
    var isFavourite: Bool
    
    init(with model: Starship) {
        name = model.name
        length = model.length
        rating = model.hyperdriveRating
        isFavourite = model.isSelected ?? false
    }

}
