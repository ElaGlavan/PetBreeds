//
//  Router.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation
import UIKit

protocol RouterType {
    func navigateToPetsViewController()
    func navigateToPetDetailsViewController(with viewModel: PetViewModel)
}

class Router: RouterType {
    let storyboard: UIStoryboard
    let petsNavigationController: UINavigationController
    let dataFetcher = HttpDataFecher()
    
    init(storyboard: UIStoryboard, petsNavigationController: UINavigationController) {
        self.storyboard = storyboard
        self.petsNavigationController = petsNavigationController
    }
    
    func navigateToPetsViewController() {
        let viewController = storyboard.instantiateViewController(identifier: "PetsViewController") as! PetsViewController
        let interactor = PetsInteractor(dataFecher: dataFetcher)
        let petsPresenter = PetsPresenter(view: viewController, router: self, interactor: interactor)
        viewController.presenter = petsPresenter
        petsNavigationController.setViewControllers([viewController], animated: false)
    }
    
    func navigateToPetDetailsViewController(with viewModel: PetViewModel) {
        let viewController = storyboard.instantiateViewController(identifier: "PetDetailsViewController") as! PetDetailsViewController
        viewController.viewModel = viewModel
        petsNavigationController.pushViewController(viewController, animated: true)
    }
}
