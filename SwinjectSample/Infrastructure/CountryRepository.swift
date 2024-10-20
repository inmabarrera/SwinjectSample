//
//  CountryRepository.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation

protocol CountryRepositoryProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

class CountryRepository: CountryRepositoryProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        networkService.fetchCountries(completion: completion)
    }
}
