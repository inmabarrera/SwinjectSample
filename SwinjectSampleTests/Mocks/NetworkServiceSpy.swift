//
//  NetworkServiceSpy.swift
//  SwinjectSampleTests
//
//  Created by Inma on 16/10/24.
//

import XCTest
@testable import SwinjectSample

class NetworkServiceSpy: NetworkService {
    var fetchCountriesResult: Result<[Country], Error>?
    var fetchPostsResult: Result<[Post], Error>?

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        if let result = fetchCountriesResult {
            completion(result)
        }
    }

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        if let result = fetchPostsResult {
            completion(result)
        }
    }
}
