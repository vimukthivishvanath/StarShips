//
//  StarShipListViewController.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on9/10/21.
//

import UIKit
import MBProgressHUD

class StarshipListViewController: UITableViewController,AlertDisplayer{
    
    //MARK: - Properties
    
    private var isInitialLoading = true
    lazy var starshipViewModel = { StarshipListViewModel()}()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableviewCell()
        initializeViewModel()
        starshipViewModel.delegate = self
        self.title = "Starship List"
    }
    
    //MARK: - Helpers
    
    func setupTableviewCell(){
        tableView?.register(UINib(nibName: StarshipTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StarshipTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.prefetchDataSource = self
    }
    
    //Used objc in case of usage of pull to refresh
    @objc
    func initializeViewModel(){
        
        if Reachability.isConnectedToNetwork() {
            if (isInitialLoading) {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            starshipViewModel.getStarships()
        } else {
            isInitialLoading = false
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.refreshControl?.endRefreshing()
                
            }
            
            print("Internet Connection not Available!")
            displaySingleActionAlert(with: .error, message: "NO_INTERNET".localizedString())
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= starshipViewModel.currentCount
    }
}


//MARK: - Tableview Delegate and Datasource Methods

extension StarshipListViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipViewModel.totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarshipTableViewCell.identifier, for: indexPath) as! StarshipTableViewCell
        if isLoadingCell(for: indexPath) {
            cell.configureLoadingCells()
        }else{
            let starship = starshipViewModel.starship(at: indexPath.row)
            cell.delegate = self
            cell.configure(with: StarshipListCellViewModel(with: starship), index: indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = starshipViewModel.starshipArray[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "StarshipDetailsViewController") as! StarshipDetailsViewController
        newViewController.selectedStarshipModel = selectedModel
        newViewController.selectedIndex = indexPath.row
        newViewController.starshipViewModel = starshipViewModel
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
    }
}


//MARK: - Tableview Prefetching Delegate Methods

extension StarshipListViewController : UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            isInitialLoading = false
            initializeViewModel()
        }
    }
    
}

//MARK: - StarshipTableViewCell Delegate Methods

extension StarshipListViewController: StarshipTableViewCellDelegate{
    func starshipTableViewCell(_ cell: StarshipTableViewCell, didTapFavouriteWith viewModel: StarshipListCellViewModel, index:Int) {
        if viewModel.isFavourite{
            starshipViewModel.starshipArray[index].isSelected = true
        }else{
            starshipViewModel.starshipArray[index].isSelected = false
        }
    }    
}

//MARK: - StarshipViewModel Delegate Methods

extension StarshipListViewController : StarshipViewModelDelegate {
    
    func onFetchCompleted() {
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed(with errorMessage: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        displaySingleActionAlert(with: .error, message: errorMessage)
    }
    
}

//MARK: - StarshipViewModel Delegate Methods

extension StarshipListViewController:StarshipDetailsViewControllerDelegate{
    
    func didDismissView(with updatedModel: Starship, index: Int) {
        starshipViewModel.starshipArray[index].isSelected = updatedModel.isSelected
        DispatchQueue.main.async { self.tableView.reloadData()}
    }
    
}
