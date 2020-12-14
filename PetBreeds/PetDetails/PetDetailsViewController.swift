//
//  PetDetailsViewController.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import Foundation
import UIKit

class PetDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PetViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension PetDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell", for: indexPath) as! ProfileImageTableViewCell
            cell.updateCell(with: viewModel.name, image: viewModel.image)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.updateCell(with: indexPath, viewModel: viewModel)
            return cell
        }
    }
}

