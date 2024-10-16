//
//  NetworkService.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation

protocol NetworkService {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let countryResponse = try JSONDecoder().decode([CountryResponse].self, from: data)
                let countries = countryResponse.map {
                    Country(name: $0.name.common, capital: $0.capital?.first, population: $0.population)
                }
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
