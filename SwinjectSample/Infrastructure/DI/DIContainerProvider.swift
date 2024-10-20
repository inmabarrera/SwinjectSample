//
//  DIContainerProvider.swift
//  SwinjectSample
//
//  Created by Inma on 20/10/24.
//

class DIContainerProvider {
    static var shared: DIContainerProtocol = DIContainer.shared
}

protocol DIContainerProtocol {
    
    var networkService: NetworkService { get }
    var countryRepository: CountryRepositoryProtocol { get }
}
