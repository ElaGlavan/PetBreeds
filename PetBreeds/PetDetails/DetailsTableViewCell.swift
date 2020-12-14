//
//  DetailsTableViewCell.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 13/12/2020.
//

import Foundation
import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailsLabel.numberOfLines = 2
    }
    
    func updateCell(with indexPath: IndexPath, viewModel: PetViewModel)  {
        var text = String()
        if indexPath.row == 0 {
            text = cellType(cell: .origin, viewModel: viewModel)
        } else if indexPath.row == 1 {
            text = cellType(cell: .lifeSpan, viewModel: viewModel)
        } else {
            text = cellType(cell: .temperament, viewModel: viewModel)
        }
        detailsLabel.text = text
    }
    
    func cellType(cell: CellType, viewModel: PetViewModel!) -> String {
        switch cell {
        case .origin:
            guard let origin = viewModel.origin  else {
                return "Origin: " + "unknown"
            }
            return "Origin: " + origin
        case .lifeSpan:
            guard let lifeSpan = viewModel.lifeSpan else {
                return "Life Span: " + "unknown"
            }
            return "Life Span: " + lifeSpan + " years"
        case .temperament:
            guard let temperament = viewModel.temperament else {
                return "Temperament: " + "unknown"
            }
            return "Temperament: " + temperament
        }
    }
}

enum CellType {
    case origin
    case lifeSpan
    case temperament
}
