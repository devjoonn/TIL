//
//  LocationFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/10/23.
//

import UIKit
import Combine

protocol LocationFactory {
    func makeModule(locationCoordinator: LocationCoordinator) -> UIViewController
}

struct LocationFactoryImp: LocationFactory {
    private(set) var urlLocations: String
    private(set) var appContainer: AppContainer
    
    func makeModule(locationCoordinator: LocationCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let locationRepository = LocationRepositoryImp(remoteServices: appContainer.apiClient)
        let loadLocationsUseCase = LoadLocationsUseCaseImp(locationRepository: locationRepository,
                                                           urlLocations: urlLocations)
        let lastPageUseCase = LastPageValidationUseCaseImp()
        let locationViewModel = LocationViewModelImp(state: state,
                                                     loadLocationsUseCase: loadLocationsUseCase,
                                                     lastPageUseCase: lastPageUseCase)
        let controller = LocationsViewController(viewModel: locationViewModel)
        return controller
    }
}
