//
//  DIContainer.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation
import Swinject

class DIContainer: DIContainerProtocol {

    // MARK: - Singleton
    static let shared = DIContainer()

    // MARK: - Properties
    private let container: Container

    // MARK: - Initializer
    private init() {
        container = Container()
        registerAssemblies()
    }

    // MARK: - Services
    var networkService: NetworkService {
        guard let service = container.resolve(NetworkService.self) else {
            fatalError("NetworkService is not registered in the container.")
        }
        return service
    }

    // MARK: - Repositories
    var countryRepository: CountryRepositoryProtocol {
        guard let repository = container.resolve(CountryRepository.self) else {
            fatalError("CountryRepository is not registered in the container.")
        }
        return repository
    }

    // MARK: - Register Assemblies
    private func registerAssemblies() {
        _ = Assembler([
            ManagerAssembly(),
            RepositoryAssembly()
        ], container: container)
    }
}

class ManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkService.self) { _ in
            NetworkServiceImpl()
        }.inObjectScope(.container)  // Singleton para toda la aplicación
    }
}

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CountryRepository.self) { resolver in
            guard let networkService = resolver.resolve(NetworkService.self) else {
                fatalError("NetworkService is not registered in the container.")
            }
            return CountryRepository(networkService: networkService)
        }.inObjectScope(.container)
    }
}
