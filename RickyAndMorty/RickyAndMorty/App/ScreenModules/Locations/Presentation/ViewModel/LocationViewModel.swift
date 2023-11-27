//
//  LocationViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/28/23.
//

import Combine

protocol LocationViewModel: BaseViewModel {
    var itemsLocationCount: Int { get }
    var lastPage: Bool { get }
    func getItemLocationViewModel(row: Int) -> ItemLocationViewModel
}

final class LocationViewModelImp: LocationViewModel {
    // MARK: - Properties
    var itemsLocationCount: Int {
        locations.count
    }
    var lastPage: Bool {
        lastPageUseCase.lastPage
    }
    var state: PassthroughSubject<StateController, Never>
    
    private var loadLocationsUseCase: LoadLocationsUseCase
    private var lastPageUseCase: LastPageValidationUseCase
    private var locations: [Location] = []
    
    // MARK: - Life Cycles
    init(state: PassthroughSubject<StateController, Never>,
         loadLocationsUseCase: LoadLocationsUseCase,
         lastPageUseCase: LastPageValidationUseCase) {
        self.state = state
        self.loadLocationsUseCase = loadLocationsUseCase
        self.lastPageUseCase = lastPageUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task { [weak self] in
            let result = await loadLocationsUseCase.excute()
            switch result {
            case .success(let locations):
                lastPageUseCase.updateLastPage(itemsCount: locations.count)
                self?.locations.append(contentsOf: locations)
                state.send(.success)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    // MARK: - Helper
    func getItemLocationViewModel(row: Int) -> ItemLocationViewModel {
        checkAndLoadMoreItems(row: row)
        let location = locations[row]
        let itemLocationViewModel = ItemLocationViewModel(location: location)
        return itemLocationViewModel
    }
    
    private func checkAndLoadMoreItems(row: Int) {
        lastPageUseCase.checkAndLoadMoreItems(row: row, actualItems: locations.count, action: viewDidLoad)
    }
}
