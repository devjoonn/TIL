//
//  EpisodesViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/14/23.
//

import UIKit
import Combine

protocol EpisodesViewModel: BaseViewModel {
    var itemsEpisodesCount: Int { get }
    var lastPage: Bool { get }
    func getItemEpisodeViewModel(row: Int) -> ItemEpisodeViewModel
}

final class EpisodesViewModelImp: EpisodesViewModel {
    // MARK: - Properties
    var itemsEpisodesCount: Int {
        episodes.count
    }
    var lastPage: Bool {
        lastPageVaildationUseCase.lastPage
    }
    var state: PassthroughSubject<StateController, Never>
    
    private var loadEpisodesUseCase: LoadEpisodesUseCase
    private var lastPageVaildationUseCase: LastPageValidationUseCase
    private var episodes: [Episode] = []
    
    // MARK: - Life Cycles
    init(state: PassthroughSubject<StateController, Never>, 
         loadEpisodesUseCase: LoadEpisodesUseCase,
         lastPageVaildationUseCase: LastPageValidationUseCase) {
        self.state = state
        self.loadEpisodesUseCase = loadEpisodesUseCase
        self.lastPageVaildationUseCase = lastPageVaildationUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            let result = await loadEpisodesUseCase.excute()
            switch result {
            case .success(let episodesResult):
                lastPageVaildationUseCase.updateLastPage(itemsCount: episodesResult.count)
                episodes.append(contentsOf: episodesResult)
                state.send(.success)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    // MARK: - Helper
    func getItemEpisodeViewModel(row: Int) -> ItemEpisodeViewModel {
        lastPageVaildationUseCase.checkAndLoadMoreItems(
            row: row,
            actualItems: episodes.count,
            action: viewDidLoad)
        
        let episode = episodes[row]
        return ItemEpisodeViewModel(episode: episode)
    }
}
