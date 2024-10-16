//
//  Models.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import Foundation

struct Country: Identifiable, Decodable {
    var id: String { name }
    let name: String
    let capital: String?
    let population: Int
}

struct CountryResponse: Decodable {
    let name: Name
    let capital: [String]?
    let population: Int

    struct Name: Decodable {
        let common: String
    }
}

struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}
