//
//  PetsCollectionViewCellTests.swift
//  PetBreedsTests
//
//  Created by Mihaela Glavan on 14/12/2020.
//

import XCTest
@testable import PetBreeds

class PetsCollectionViewCellTests: XCTestCase {
    
    var subject: PetsCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        subject = makeCell()
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }
  
    func test_setUpDesign_configuresTheCell()  {
        let contentViewBackgroundColor = UIColor(named: "#404B62")
        let contentViewBorderWidth: CGFloat = 2
        let contentViewCornerRadius: CGFloat = 20
        let contentViewBorderColor = UIColor(named: "#404B62")?.cgColor
        
        let petNameFont = UIFont(name: "Mulish-Regular", size: 18)
        
        let petImageProfileCornerRadius: CGFloat = 10
        
        let detailsButtonCornerRadius: CGFloat = 10
        let detailsButtonBorderWidth: CGFloat = 2
        let detailsButtonTitleLabelFont = UIFont(name: "Mulish-Regular", size: 20)
        
        subject.setUpDesign()
        
        XCTAssertEqual(subject.contentView.backgroundColor, contentViewBackgroundColor)
        XCTAssertEqual(subject.contentView.layer.borderWidth, contentViewBorderWidth)
        XCTAssertEqual(subject.contentView.layer.cornerRadius, contentViewCornerRadius)
        XCTAssertEqual(subject.contentView.layer.borderColor, contentViewBorderColor)
        XCTAssertEqual(subject.petName.font, petNameFont)
        XCTAssertEqual(subject.petImageProfile.layer.cornerRadius, petImageProfileCornerRadius)
        XCTAssertEqual(subject.detailsButton.layer.cornerRadius, detailsButtonCornerRadius)
        XCTAssertEqual(subject.detailsButton.layer.borderWidth, detailsButtonBorderWidth)
        XCTAssertEqual(subject.detailsButton.titleLabel?.font, detailsButtonTitleLabelFont)
    }
    
    func test_update_petNameIsUpdated() {
        let petViewModel = PetViewModel(name: "Misha", image: "https://cdn2.thecatapi.com/images/B1ERTmgph.jpg", origin: "", lifeSpan: "", temperament: "")
        let viewModel = PetsViewModel(pets: [petViewModel])
        let indexPath = IndexPath(row: 0, section: 0)
        subject.update(with: viewModel, at: indexPath)
        
        XCTAssertEqual(subject.petName.text, viewModel.pets[indexPath.row].name)
    }
    
    private func makeCell() -> PetsCollectionViewCell {
        let cellNib = Bundle.main.loadNibNamed("PetsCollectionViewCell", owner: self, options: nil)!
        return cellNib.first as! PetsCollectionViewCell
    }
}
