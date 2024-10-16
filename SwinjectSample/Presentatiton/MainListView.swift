//
//  MainListView.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import SwiftUI

struct MainListView: View {
    @ObservedObject var viewModel: MainListViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Countries")
                    .font(.largeTitle)
                    .padding()

                List(viewModel.countries) { country in
                    VStack(alignment: .leading) {
                        Text(country.name)
                            .font(.headline)
                        if let capital = country.capital {
                            Text("Capital: \(capital)")
                        }
                        Text("Population: \(country.population)")
                    }
                }

                Button("Fetch Countries") {
                    viewModel.fetchCountries()
                }
                .padding()

                Text("Posts")
                    .font(.largeTitle)
                    .padding()

                List(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                    }
                }

                Button("Fetch Posts") {
                    viewModel.fetchPosts()
                }
                .padding()

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Countries & Posts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
