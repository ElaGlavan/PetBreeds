//
//  PetsPresenterTests.swift
//  PetBreedsTests
//
//  Created by Mihaela Glavan on 14/12/2020.
//

import XCTest
@testable import PetBreeds

class PetsPresenterTests: XCTestCase {
 
    var subject: PetsPresenter!
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        subject = PetsPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
    }

    override func tearDown() {
        subject = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_givenInteractorHasStoreBreeds_chechingTheViewModel() {
        
        let petViewModel1 = PetViewModel(name: "American Curl", image: "https://cdn2.thecatapi.com/images/xnsqonbjW.jpg", origin: "Italy", lifeSpan: "10", temperament: "Curious")
        
        let petViewModel2 = PetViewModel(name: "American", image: "https://cdn2.thecatapi.com/images/JFPROfGtQ.jpg", origin: "Uk", lifeSpan: "20", temperament: "Intelligent")
        
        let viewModel = PetsViewModel(pets: [petViewModel1, petViewModel2])
        
        subject.viewDidLoad()
        XCTAssertNotNil(self.mockView.viewModel, "viewModel is not nill")
        XCTAssertEqual(self.mockView.viewModel.pets, viewModel.pets)
    }
}

class MockView: PetsView {
    var viewModelDidUpdate: (() -> Void)?
    
    var viewModel: PetsViewModel = .init(pets: []) {
        didSet {
            viewModelDidUpdate?()
        }
    }
    
    var filteredViewModel: PetsViewModel = .init(pets: []) {
        didSet {
            viewModelDidUpdate?()
        }
    }
}

class MockRouter: RouterType {
    func navigateToPetsViewController() {
        
    }
    
    func navigateToPetDetailsViewController(with viewModel: PetViewModel) {
        
    }
}

class MockInteractor: PetsInteractorType {
    func fetchBreeds(for endpoint: Endpoint, completion: @escaping ([Breed]) -> Void) {
        switch endpoint {
        case .catBreeds:
            let breed = Breed(name: "American Curl", life_span: "10", temperament: "Curious", origin: "Italy", image: ImageBreads.init(id: "", url: "https://cdn2.thecatapi.com/images/xnsqonbjW.jpg"))
            completion([breed])
        case .dogBreeds:
            let breed1 = Breed(name: "American", life_span: "20", temperament: "Intelligent", origin: "Uk", image: ImageBreads.init(id: "", url: "https://cdn2.thecatapi.com/images/JFPROfGtQ.jpg"))
            completion([breed1])
        default:
            completion([])
        }
    }
}
    
