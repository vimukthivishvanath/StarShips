//
//  StarShipsModel.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import Foundation

struct Starship: Codable{
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
    var pilots: [URL]?
    var films:[URL]?
    var created: String?
    var edited: String?
    var url: URL?
    var isSelected: Bool?
    
    enum CodingKeys: String,CodingKey{
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case MGLT
        case starshipClass = "starship_class"
        case pilots
        case films
        case created
        case edited
        case url
        case isSelected 
    }
}
struct StarshipModel: Codable{
    
    var count: Int?
    var next: URL?
    var previous: URL?
    var results: [Starship]?
    
}

