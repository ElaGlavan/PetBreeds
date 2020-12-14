//
//  PetsCollectionViewCell.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation
import UIKit

protocol PetCellDelegate: class {
    func detailsButtonTapped(with indexPath: IndexPath)
}

protocol SessionIdentifiable {
    var sessionIdentifier: UUID { get }
}

class PetsCollectionViewCell: UICollectionViewCell, SessionIdentifiable {
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var petImageProfile: UIImageView!
    @IBAction func detailsButtonTapped(_ sender: Any) {
        delegate.detailsButtonTapped(with: indexPath)
    }
    
    var indexPath = IndexPath()
    weak var delegate: PetCellDelegate!
    var sessionIdentifier = UUID()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDesign()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sessionIdentifier = UUID()
        petImageProfile.image = nil
    }
    
    func update(with viewModel: PetsViewModel, at indexPath: IndexPath) {
        guard let imageURL = viewModel.pets[indexPath.row].image, let url = URL(string: imageURL) else {
            return
        }
        petImageProfile.contentMode = .scaleAspectFill
        petImageProfile.load(url: url, sessionIdentifier: sessionIdentifier, cell: self)
        petName.text = viewModel.pets[indexPath.row].name
    }
    
    func setUpDesign() {
        self.contentView.backgroundColor = UIColor(named: "#404B62")
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderColor = UIColor(named: "#404B62")?.cgColor
      
        
        petName.font = UIFont(name: "Mulish-Regular", size: 18)
        
        petImageProfile.layer.cornerRadius = 10
        
        detailsButton.layer.cornerRadius = 10
        detailsButton.layer.borderWidth = 2
        detailsButton.titleLabel?.font = UIFont(name: "Mulish-Regular", size: 20)
        detailsButton.layer.borderColor = UIColor(named: "#404B62")?.cgColor
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.setTitleColor(UIColor(named: "#404B62"), for: .normal)
    }
}

extension UIImageView {
    func load(url: URL, sessionIdentifier: UUID, cell: SessionIdentifiable) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                guard sessionIdentifier == cell.sessionIdentifier else {
                    print("dropping request response for \(sessionIdentifier)")
                    return
                }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image.resized(to: .init(width: 200, height: 200))
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
