//
//  TestsDIContainer.swift
//  SwinjectSampleTests
//
//  Created by Inma on 16/10/24.
//

import XCTest
@testable import SwinjectSample
import Swinject

class TestsDIContainer: DIContainerProtocol {
    
    static let shared = TestsDIContainer()

    private let container: Container

    private init() {
        container = Container()
        registerTestMocks()
    }

    // MARK: - Register Mocks
    private func registerTestMocks() {
        container.register(NetworkService.self) { _ in
            NetworkServiceSpy()
        }

        container.register(CountryRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self) as! NetworkServiceSpy
            return CountryRepositorySpy(networkService: networkService)
        }
    }

    // MARK: - Resolve Mocks
    var networkService: NetworkService {
        return container.resolve(NetworkService.self) as! NetworkServiceSpy
    }

    var countryRepository: CountryRepositoryProtocol {
        return container.resolve(CountryRepository.self) as! CountryRepositorySpy
    }
}
