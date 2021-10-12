//
//  DetailTableViewCell.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import UIKit


class DetailTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Helpers
    
    func configure(with viewModel: StarshipDetailCellViewModel, index:Int){
        switch index{
        case FieldType.name.rawValue:
            
            self.typeLabel.text = "Name"
            self.infoLabel.text = viewModel.name
            
        case FieldType.model.rawValue:

            self.typeLabel.text = "Model"
            self.infoLabel.text = viewModel.model

        case FieldType.manufacturer.rawValue:

            self.typeLabel.text = "Manufacturer"
            self.infoLabel.text = viewModel.manufacturer

        case FieldType.costInCredits.rawValue:

            self.typeLabel.text = "Cost In Credits"
            self.infoLabel.text = viewModel.costInCredits

        case FieldType.length.rawValue:

            self.typeLabel.text = "Length"
            self.infoLabel.text = viewModel.length

        case FieldType.maxAtmospheringSpeed.rawValue:

            self.typeLabel.text = "Speed"
            self.infoLabel.text = viewModel.maxAtmospheringSpeed

        case FieldType.crew.rawValue:

            self.typeLabel.text = "Crew"
            self.infoLabel.text = viewModel.crew

        case FieldType.passengers.rawValue:

            self.typeLabel.text = "Passengers"
            self.infoLabel.text = viewModel.passengers

        case FieldType.cargoCapacity.rawValue:

            self.typeLabel.text = "Cargo Capacity"
            self.infoLabel.text = viewModel.cargoCapacity

        case FieldType.consumables.rawValue:

            self.typeLabel.text = "Consumables"
            self.infoLabel.text = viewModel.consumables

        case FieldType.hyperdriveRating.rawValue:

            self.typeLabel.text = "Rating"
            self.infoLabel.text = viewModel.hyperdriveRating

        case FieldType.MGLT.rawValue:

            self.typeLabel.text = "MGLT"
            self.infoLabel.text = viewModel.MGLT

        case FieldType.starshipClass.rawValue:

            self.typeLabel.text = "Ship Class"
            self.infoLabel.text = viewModel.starshipClass
            
        default:
            self.typeLabel.text = "No Data"
            self.infoLabel.text = "No Data"
        }
       
    }
}
