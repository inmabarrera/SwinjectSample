//
//  CountryRepositorySpy.swift
//  SwinjectSampleTests
//
//  Created by Inma on 16/10/24.
//

import XCTest
@testable import SwinjectSample

class CountryRepositorySpy: CountryRepository {
    var fetchCountriesResult: Result<[Country], Error>?

    override func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        if let result = fetchCountriesResult {
            completion(result)
        }
    }
}
