//
//  SwinjectSampleApp.swift
//  SwinjectSample
//
//  Created by Inma on 16/10/24.
//

import SwiftUI

@main
struct SwinjectSampleApp: App {
    var body: some Scene {
        WindowGroup {
            // Resolver las dependencias desde el contenedor
            let countryRepository = DIContainer.shared.countryRepository
            let networkService = DIContainer.shared.networkService
            
            // Crear el ViewModel manualmente
            let mainListViewModel = MainListViewModel(countryRepository: countryRepository, networkService: networkService)
            
            // Pasar el ViewModel a la vista
            MainListView(viewModel: mainListViewModel)
        }
    }
}


