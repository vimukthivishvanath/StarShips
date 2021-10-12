//
//  StarshipTableViewCell.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import UIKit

protocol StarshipTableViewCellDelegate: AnyObject {
    func starshipTableViewCell(_ cell:StarshipTableViewCell, didTapFavouriteWith viewModel:StarshipListCellViewModel, index:Int)
}

class StarshipTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "StarshipTableViewCell"
    weak var delegate:StarshipTableViewCellDelegate?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shipImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private var starshipCellModel : StarshipListCellViewModel?
    private var selectedIndex: Int = 0
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .gray
        favouriteButton.setImage( UIImage(systemName:"star"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    //MARK: - Helpers
    
    func configureLoadingCells(){
        nameLabel.alpha = 0
        lengthLabel.alpha = 0
        ratingLabel.alpha = 0
        shipImageView.alpha = 0
        favouriteButton.alpha = 0
        
        loadingIndicator.startAnimating()
    }
    
    func configure(with viewModel: StarshipListCellViewModel, index:Int){
        //update UI show real data
        nameLabel.alpha = 1
        lengthLabel.alpha = 1
        ratingLabel.alpha = 1
        shipImageView.alpha = 1
        favouriteButton.alpha = 1
        
        selectedIndex = index
        starshipCellModel = viewModel
        nameLabel?.text = "Name: \(viewModel.name ?? "")"
        lengthLabel?.text = "Length: \(viewModel.length ?? "")"
        ratingLabel?.text = "HyperDrive Rating: \(viewModel.rating ?? "")"
        
        if viewModel.isFavourite{
            favouriteButton.setImage( UIImage(systemName:"star.fill"), for: .normal)
        }else{
            favouriteButton.setImage( UIImage(systemName:"star"), for: .normal)
        }
        
        
        loadingIndicator.stopAnimating()
    }
    
    
    
    @IBAction func didTapOnTheFavouriteButton(_ sender: Any) {
        guard let starshipCellModel = starshipCellModel else{
            return
        }
        var newStarshipCellModel = starshipCellModel
        newStarshipCellModel.isFavourite = !starshipCellModel.isFavourite
        
        delegate?.starshipTableViewCell(self, didTapFavouriteWith: newStarshipCellModel, index: selectedIndex)
        //Prepares a reusable cell for reuse
        prepareForReuse()
        configure(with: newStarshipCellModel,index: selectedIndex )
        
    }
}
