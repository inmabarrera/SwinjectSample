//
//  MainListViewModelTests.swift
//  SwinjectSampleTests
//
//  Created by Inma on 16/10/24.
//

import XCTest
@testable import SwinjectSample

class MainListViewModelTests: BaseTestCase {
    
    var viewModel: MainListViewModel!
    var networkServiceSpy: NetworkServiceSpy!
    var countryRepositorySpy: CountryRepositorySpy!
    
    override func setUp() {
        super.setUp()
        
        // Retrieve the mocks from the test container
        networkServiceSpy = DIContainerProvider.shared.networkService as!
                                    NetworkServiceSpy
        countryRepositorySpy = DIContainerProvider.shared.countryRepository as!
                                    CountryRepositorySpy
        
        // Inject the mocks into the ViewModel
        viewModel = MainListViewModel(countryRepository: countryRepositorySpy,
                                      networkService: networkServiceSpy)
    }
    
    override func tearDown() {
        viewModel = nil
        networkServiceSpy = nil
        countryRepositorySpy = nil
        super.tearDown()
    }
    
    
    func testFetchCountries_Success() {
        let mockCountries = [Country(name: "Country 1", capital: "Capital 1", population: 1000)]
        countryRepositorySpy.fetchCountriesResult = .success(mockCountries)
        
        // Crear una expectativa
        let expectation = self.expectation(description: "Fetch countries completes successfully")
        
        viewModel.fetchCountries()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.countries.count, 1)
            XCTAssertEqual(self.viewModel.countries.first?.name, "Country 1")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCountries_Failure() {
        countryRepositorySpy.fetchCountriesResult = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch countries"]))
        
        let expectation = self.expectation(description: "Fetch countries fails with an error")
        
        viewModel.fetchCountries()
        
        DispatchQueue.main.async {
            // Assert: Verificar si el error fue manejado correctamente
            XCTAssertEqual(self.viewModel.countries.count, 0)
            XCTAssertEqual(self.viewModel.errorMessage, "Error fetching countries: Failed to fetch countries")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchPosts_Success() {
        let mockPosts = [Post(id: 1, title: "Post 1", body: "Body 1")]
        networkServiceSpy.fetchPostsResult = .success(mockPosts)
        
        let expectation = self.expectation(description: "Fetch posts completes successfully")
        
        viewModel.fetchPosts()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.posts.count, 1)
            XCTAssertEqual(self.viewModel.posts.first?.title, "Post 1")
            
            // Marcar la expectativa como cumplida
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchPosts_Failure() {
        networkServiceSpy.fetchPostsResult = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch posts"]))
        
        let expectation = self.expectation(description: "Fetch posts fails with an error")
        
        viewModel.fetchPosts()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.posts.count, 0)
            XCTAssertEqual(self.viewModel.errorMessage, "Error fetching posts: Failed to fetch posts")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
