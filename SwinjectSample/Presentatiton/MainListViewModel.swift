//
//  MainListViewModel.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation

class MainListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var posts: [Post] = []
    @Published var errorMessage: String?

    private let countryRepository: CountryRepositoryProtocol
    private let networkService: NetworkService

    init(countryRepository: CountryRepositoryProtocol, networkService: NetworkService) {
        self.countryRepository = countryRepository
        self.networkService = networkService
    }

    func fetchCountries() {
        countryRepository.fetchCountries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self?.countries = countries
                case .failure(let error):
                    self?.errorMessage = "Error fetching countries: \(error.localizedDescription)"
                }
            }
        }
    }

    func fetchPosts() {
        networkService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    self?.errorMessage = "Error fetching posts: \(error.localizedDescription)"
                }
            }
        }
    }
}
