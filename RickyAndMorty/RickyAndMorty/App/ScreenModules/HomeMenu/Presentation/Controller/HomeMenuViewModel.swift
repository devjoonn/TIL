//
//  HomeMenuViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//
import Combine
import Foundation

protocol HomeMenuViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    var menuItemsCount: Int { get }
    func viewDidLoad()
    func getItemMenuViewModel(indexPath: IndexPath) -> ItemHomeMenuViewModel
    func getMenuItem(indexPath: IndexPath) -> MenuItem
}

final class HomeMenuViewModelImp: HomeMenuViewModel {
    // MARK: - Properties
    var state: PassthroughSubject<StateController, Never>
    
    var menuItemsCount: Int {
        menuItems.count
    }
    
    private let loadMenuUseCase: LoadMenuUseCase
    private var menuItems: [MenuItem] = []
    
    
    // MARK: - Life Cycles
    init(state: PassthroughSubject<StateController, Never>, loadMenuUseCase: LoadMenuUseCase) {
        self.state = state
        self.loadMenuUseCase = loadMenuUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            let result = await loadMenuUseCase.excute()
            updateUI(result: result)
        }
    }
    
    // MARK: - Helpers
    private func updateUI(result: Result<[MenuItem], Error>) {
        switch result {
        case .success(let menuItems):
            self.menuItems = menuItems
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemMenuViewModel(indexPath: IndexPath) -> ItemHomeMenuViewModel {
        let menuItem = menuItems[indexPath.row]
        return ItemHomeMenuViewModel(menuItem: menuItem)
    }
    
    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        menuItems[indexPath.row]
    }

}
