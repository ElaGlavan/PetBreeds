//
//  PetsInteractor.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation

protocol PetsInteractorType {
    func fetchBreeds(for endpoint: Endpoint, completion: @escaping ([Breed]) -> Void)
}

class PetsInteractor: PetsInteractorType {
    var dataFecher = HttpDataFecher()
    
    init(dataFecher: HttpDataFecher) {
        self.dataFecher = dataFecher 
    }
    
    func fetchBreeds(for endpoint: Endpoint, completion: @escaping ([Breed]) -> Void) {
        dataFecher.fetchBreeds(for: endpoint) { (data) in
            guard let data = data else {
                return
            }
            let decoded = try! JSONDecoder().decode([Breed].self, from: data)
            completion(decoded)
        }
    }
}
