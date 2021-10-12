//
//  StarshipDetailsViewController.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 9/10/21.
//

import UIKit

enum FieldType:Int {
    case name = 0
    case model
    case manufacturer
    case costInCredits
    case length
    case maxAtmospheringSpeed
    case crew
    case passengers
    case cargoCapacity
    case consumables
    case hyperdriveRating
    case MGLT
    case starshipClass
}

protocol StarshipDetailsViewControllerDelegate:AnyObject {
    func didDismissView(with updatedModel:Starship, index:Int)
}

class StarshipDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: StarshipDetailsViewControllerDelegate!
    private let cellIdentifier = "DetailTableViewCell"
    var selectedStarshipModel:Starship?
    var starshipViewModel: StarshipListViewModel?
    var selectedIndex: Int = 0
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        handleFavouriteButton()
    }
    
    
    //MARK: - Helpers
    
    func handleFavouriteButton(){
        if let selectedStarshipModel = selectedStarshipModel {
            guard let selected  = selectedStarshipModel.isSelected else {
                return
            }
            if selected {
                favouriteButton.setImage( UIImage(systemName:"star.fill"), for: .normal)
            }else{
                favouriteButton.setImage( UIImage(systemName:"star"), for: .normal)
            }
        }
    }
    
    func initialConfiguration(){
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        favouriteButton.setImage( UIImage(systemName:"star"), for: .normal)
    }
    
    @IBAction func didTapOnFavouriteButton(_ sender: Any) {
        //Handle Favourite button action and UI
        if selectedStarshipModel?.isSelected != nil  {
            let selected = selectedStarshipModel?.isSelected
            selectedStarshipModel?.isSelected = !selected!
        }else{
            selectedStarshipModel?.isSelected = true
        }
        
        handleFavouriteButton()
        
    }
    
    @IBAction func didTapOnDismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate.didDismissView(with: self.selectedStarshipModel!,index: self.selectedIndex)
        }
    }
    
}

//MARK: - Tableview Delegate and Datasource Methods

extension StarshipDetailsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        let cellViewModel = StarshipDetailCellViewModel(with: selectedStarshipModel!)
        cell.configure(with: cellViewModel, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
