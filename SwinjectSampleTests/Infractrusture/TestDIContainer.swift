//
//  TestDIContainer.swift
//  SwinjectSampleTests
//
//  Created by Inma on 16/10/24.
//

import XCTest
@testable import SwinjectSample
import Swinject

class TestDIContainer {
    static let shared = TestDIContainer()

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
    var networkService: NetworkServiceSpy {
        return container.resolve(NetworkService.self) as! NetworkServiceSpy
    }

    var countryRepository: CountryRepositorySpy {
        return container.resolve(CountryRepository.self) as! CountryRepositorySpy
    }
}
