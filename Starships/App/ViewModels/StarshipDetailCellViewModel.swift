//
//  StarshipDetailViewModel.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 10/10/21.
//

import Foundation
import UIKit


struct StarshipDetailCellViewModel{
    var name: String?
    var model: String?
    var manufacturer: String?
    var costInCredits: String?
    var length: String?
    var maxAtmospheringSpeed: String?
    var crew: String?
    var passengers: String?
    var cargoCapacity: String?
    var consumables: String?
    var hyperdriveRating: String?
    var MGLT: String?
    var starshipClass: String?
    var isSelected: Bool?
    
    init(with modelObj: Starship) {
        name = modelObj.name
        model = modelObj.model
        manufacturer = modelObj.manufacturer
        costInCredits = modelObj.costInCredits
        length = modelObj.length
        maxAtmospheringSpeed = modelObj.maxAtmospheringSpeed
        crew = modelObj.crew
        passengers = modelObj.passengers
        cargoCapacity = modelObj.cargoCapacity
        consumables = modelObj.consumables
        hyperdriveRating = modelObj.hyperdriveRating
        MGLT = modelObj.MGLT
        starshipClass = modelObj.starshipClass
        isSelected = modelObj.isSelected
    }
    
    
}
