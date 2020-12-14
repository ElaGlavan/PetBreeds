//
//  ProfileImageTableViewCell.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 13/12/2020.
//

import Foundation
import UIKit

class ProfileImageTableViewCell: UITableViewCell, SessionIdentifiable {
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    
    var sessionIdentifier = UUID()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        petImage.layer.cornerRadius = 10
        petImage.contentMode = .scaleAspectFill
    }
    
    func updateCell(with name: String, image: String?) {
        guard let image = image, let url = URL(string: image) else {
            return
        }
        petImage.load(url: url, sessionIdentifier: sessionIdentifier, cell: self)
        petName.text = name
    }
}



