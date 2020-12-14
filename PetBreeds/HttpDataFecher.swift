//
//  HttpDataFecher.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation

enum Endpoint {
    case catBreeds
    case catBreedsByID
    case dogBreeds
    case dogBreedsByID
    
    var request: URLRequest? {
        let catHost = "https://api.thecatapi.com/"
        let dogHost = "https://api.thedogapi.com/"
        let catSecretKey = "0cb4ff69-5e2d-4d50-8e67-98668c0e8ef5"
        let dogSecretKey = "cc767c93-cadc-4339-abe2-ce75bc967b91"
        
        switch self {
        case .catBreeds: return urlRequest(with: catHost, secretKey: catSecretKey, parameters: "v1/breeds")
        case .catBreedsByID: return urlRequest(with: catHost, secretKey: catSecretKey, parameters: "v1/images/search?breed_ids=")
        case .dogBreeds: return urlRequest(with: dogHost, secretKey: dogSecretKey, parameters: "v1/breeds")
        case .dogBreedsByID : return urlRequest(with: dogHost, secretKey: dogSecretKey, parameters: "v1/images/search?breed_ids=")
        }
    }
    
    func urlRequest(with host: String, secretKey: String, parameters: String) -> URLRequest? {
        guard let url = URL(string: host + parameters) else {
           return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue(secretKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}

protocol HttpDataFeching {
    func fetchBreeds(for endpoint: Endpoint, completion: @escaping (Data?) -> Void)
    func fetchBreedsByID(for endpoint: Endpoint, id: String, completion: @escaping (Data?) -> Void)
}

class HttpDataFecher: HttpDataFeching {
    func fetchBreeds(for endpoint: Endpoint, completion: @escaping (Data?) -> Void) {
        guard let request = endpoint.request else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            completion(data)
        }.resume()
    }
    
    func fetchBreedsByID(for endpoint: Endpoint, id: String, completion: @escaping (Data?) -> Void) {
        guard let request = endpoint.request else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            completion(data)
        }.resume()
    }
}
