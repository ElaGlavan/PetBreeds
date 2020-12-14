//
//  PetsViewController.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation
import UIKit

protocol PetsView {
    var viewModel: PetsViewModel {get set}
    var filteredViewModel: PetsViewModel {get set}
}

class PetsViewController: UIViewController, PetsView, PetCellDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userIsSearching = false
    var presenter: PetsPresenter!
    var viewModel: PetsViewModel = .init(pets: []) {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var filteredViewModel: PetsViewModel = .init(pets: []) {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        register(cell: "PetsCollectionViewCell", with: "PetsCollectionViewCell")
        setLayout(for: collectionView)
        presenter.viewDidLoad()
    }
    
    func detailsButtonTapped(with indexPath: IndexPath) {
        if userIsSearching == true {
            presenter.detailsButtonTapped(with: filteredViewModel.pets[indexPath.row])
        } else {
            presenter.detailsButtonTapped(with: viewModel.pets[indexPath.row])
        }
        
    }
    
    func register(cell: String, with nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
           collectionView?.register(nib, forCellWithReuseIdentifier: cell)
    }
    
    func setLayout(for collectionView: UICollectionView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3)
           layout.minimumInteritemSpacing = 0
           layout.minimumLineSpacing = 0
           collectionView.collectionViewLayout = layout
    }
    
    func filterBreeds(by searchTerm: String) {
        if searchTerm.count > 0 {
            userIsSearching = true
            filteredViewModel = viewModel
            let filteredResults = viewModel.pets.filter{$0.name.replacingOccurrences(of: " ", with: " ").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())}
            filteredViewModel.pets = filteredResults
        } else {
            userIsSearching = false
            filteredViewModel = viewModel
        }
    }
}

extension PetsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredViewModel.pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetsCollectionViewCell", for: indexPath) as! PetsCollectionViewCell
        cell.prepareForReuse()
        cell.indexPath = indexPath
        cell.delegate = self
        cell.update(with: filteredViewModel, at: indexPath)
        return cell
    }
}

extension PetsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(16)
    }
}

extension PetsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterBreeds(by: searchText)
        }
    }
}

extension PetsViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            filterBreeds(by: searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            filterBreeds(by: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            filterBreeds(by: searchText)
        }
    }
}
