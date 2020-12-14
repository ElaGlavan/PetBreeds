//
//  PetsViewModel.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation

struct PetsViewModel: Equatable {
    var pets: [PetViewModel]
}

struct PetViewModel: Equatable {
    var name: String
    var image: String?
    var origin: String?
    var lifeSpan: String?
    var temperament: String?

    public static func == (lhs: PetViewModel, rhs: PetViewModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.image == rhs.image &&
            lhs.origin == rhs.origin &&
            lhs.lifeSpan == rhs.lifeSpan &&
            lhs.temperament == rhs.temperament
    }
}
