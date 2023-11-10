//
//  CharacterDetailFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/29/23.
//

import UIKit
import Combine

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
    func makeOriginCoordinator(navigation: UINavigationController) -> Coordinator
    func makeLocationCoordinator(navigation: UINavigationController) -> Coordinator
}

struct CharacterDetailFactoryImp: CharacterDetailFactory {
    let urlDetail: String
    let appContainer: AppContainer
    
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        
        let characterDetailRepository = CharacterDetailRepositoryImp(remoteService: appContainer.apiClient)
        let loadCharacterDetailUseCase = LoadCharacterDetailUseCaseImp(characterDetailRepository: characterDetailRepository,
                                                                       urlDetail: urlDetail)
        let viewModel = CharacterDetailViewModelImp(state: state, 
                                                    loadCharacterDetailUseCase: loadCharacterDetailUseCase,
                                                    dataImageUseCase: appContainer.getDataImageUseCase())
        
        let controller = CharacterDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
    func makeOriginCoordinator(navigation: UINavigationController) -> Coordinator {
        let originfactory = OriginFactoryImp()
        let originCoordinator = OriginCoordinator(originFactory: originfactory, navigation: navigation)
        return originCoordinator
    }
    
    func makeLocationCoordinator(navigation: UINavigationController) -> Coordinator {
        let locationFactory = LocationFactoryImp()
        let locationCoordinator = LocationCoordinator(locationFactory: locationFactory, navigation: navigation)
        return locationCoordinator
    }
}
