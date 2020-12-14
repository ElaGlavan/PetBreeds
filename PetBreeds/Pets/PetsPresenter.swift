//
//  PetsPresenter.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation
import UIKit

protocol PetsPresenterType {
    func detailsButtonTapped(with viewModel: PetViewModel)
}

class PetsPresenter: PetsPresenterType {
    var view: PetsView
    var router: RouterType
    var interactor: PetsInteractorType
    
    init(view: PetsView, router: RouterType, interactor: PetsInteractorType) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.fetchBreeds(for: .catBreeds) { [weak self] (catBreeds) in
            var pets = [PetViewModel]()
            for breed in catBreeds {
                let petViewModel = PetViewModel(name: breed.name, image: breed.image?.url, origin: breed.origin, lifeSpan: breed.life_span, temperament: breed.temperament)
                pets.append(petViewModel)
            }
            
            self?.interactor.fetchBreeds(for: .dogBreeds) { [weak self] (dogBreeds) in
                for breed in dogBreeds {
                    let dogViewModel = PetViewModel(name: breed.name, image: breed.image?.url, origin: breed.origin, lifeSpan: breed.life_span, temperament: breed.temperament)
                    pets.append(dogViewModel)
                }
                self?.view.viewModel = .init(pets: pets)
                self?.view.filteredViewModel = .init(pets: pets)
            }
        }
    }
    
    func detailsButtonTapped(with viewModel: PetViewModel) {
        router.navigateToPetDetailsViewController(with: viewModel)
    }
}
