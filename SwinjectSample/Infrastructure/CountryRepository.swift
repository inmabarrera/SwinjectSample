//
//  CountryRepository.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation

class CountryRepository {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        networkService.fetchCountries(completion: completion)
    }
}
