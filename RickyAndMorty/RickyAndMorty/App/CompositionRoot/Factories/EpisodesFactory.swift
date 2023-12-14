//
//  EpisodesFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/2/23.
//

import UIKit
import Combine

protocol EpisodesFactory {
    func makeModule() -> UIViewController
}

struct EpisodesFactoryImp: EpisodesFactory {
    private(set) var urlEpisodes: String
    private(set) var appContainer: AppContainer
    
    
    func makeModule() -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        
        let episodesRepository = EpisodesRepositoryImp(remoteService: appContainer.apiClient)
        let loadEpisodesUseCase = LoadEpisodesUseCaseImp(episodeRepository: episodesRepository,
                                                         urlEpisodes: urlEpisodes)
        let lastPageValidationUseCase = LastPageValidationUseCaseImp()
        let episodesViewModel = EpisodesViewModelImp(state: state,
                                                     loadEpisodesUseCase: loadEpisodesUseCase,
                                                     lastPageVaildationUseCase: lastPageValidationUseCase)
        let controller = EpisodesViewController(viewModel: episodesViewModel)
        return controller
    }
}
