//
//  CharactersFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit
import Combine

protocol CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    
}

struct CharactersFactoryImp: CharactersFactory {
    let appContainer: AppContainer
    let urlList: String
    
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = appContainer.apiClient
        let characterRepository = CharacterRepositoryImp(apiClient: apiClient)
        let loadCharactersUseCase = LoadCharactersUseCaseImp(characterRepository: characterRepository, url: urlList)
        let lastPageValidationUseCase = LastPageValidationUseCaseImp()
        let viewModel = CharactersViewModelImp(loadCharactersUseCase: loadCharactersUseCase,
                                               lastPageValidationUseCase: lastPageValidationUseCase,
                                               state: state,
                                               imageDataUseCase: appContainer.getDataImageUseCase())
        let controller = CharactersViewController(viewModel: viewModel)
        controller.title = "Characters"
        return controller
    }
}
