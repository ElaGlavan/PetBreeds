//
//  Breed.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation

struct Breed: Decodable {
    var name: String
    var life_span: String?
    var temperament: String?
    var origin: String?
    var image: ImageBreads?
}

struct ImageBreads: Decodable {
    var id: String?
    var url: String?
}
