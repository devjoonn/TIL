//
//  HomeFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//
import UIKit
import Combine

protocol HomeFactory {
    func makeModule() -> UIViewController
}

struct  HomeFactoryImp: HomeFactory {
    func makeModule() -> UIViewController {
        let apiClientService = ApiClientServiceImp()
        let menuRepository = MenuRepositoryImp(apiClientService: apiClientService, urlList: Endpoint.baseUrl)
        let loadingUseCase = LoadMenuUseCaseImp(menuRepository: menuRepository)
        let state = PassthroughSubject<StateController, Never>()
        let homeViewModel = HomeMenuViewModelImp(state: state, loadMenuUseCase: loadingUseCase)
        let homeMenuController = HomeMenuController(viewModel: homeViewModel, layout: makeLayout())
        homeMenuController.title = "Rick and Morty"
        return homeMenuController
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (UIScreen.main.bounds.width - 20) / 2
        let layoutHeight = (UIScreen.main.bounds.width - 20) / 2
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        return layout
    }
}
