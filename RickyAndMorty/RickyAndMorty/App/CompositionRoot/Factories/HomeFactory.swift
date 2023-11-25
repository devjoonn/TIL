//
//  HomeFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//
import UIKit
import Combine

protocol HomeFactory {
    func makeModule(coordinator: HomeCoordinator) -> UIViewController
    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator
    func makeLocationCoordinator(navigation: UINavigationController, urlLocations: String) -> Coordinator
}

struct  HomeFactoryImp: HomeFactory {
    
    let appContainer: AppContainer
    
    func makeModule(coordinator: HomeCoordinator) -> UIViewController {
        let apiClientService = ApiClientServiceImp()
        let menuRepository = MenuRepositoryImp(apiClientService: apiClientService, urlList: Endpoint.baseUrl)
        let loadingUseCase = LoadMenuUseCaseImp(menuRepository: menuRepository)
        let state = PassthroughSubject<StateController, Never>()
        let homeViewModel = HomeMenuViewModelImp(state: state, loadMenuUseCase: loadingUseCase)
        let homeMenuController = HomeMenuController(viewModel: homeViewModel, 
                                                    layout: makeLayout(),
                                                    coordinator: coordinator)
        homeMenuController.title = AppLocalized.appName
        return homeMenuController
    }
    
    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator {
        let characterFactory = CharactersFactoryImp(appContainer: appContainer, urlList: urlList)
        let characterCoordinator = CharactersCoordinator(navigation: navigation, charactersFactory: characterFactory)
        return characterCoordinator
    }
    
    func makeLocationCoordinator(navigation: UINavigationController, urlLocations: String) -> Coordinator {
        let locationFactory = LocationFactoryImp(urlLocations: urlLocations, appContainer: appContainer)
        let locationCoordinator = LocationCoordinator(navigation: navigation, locationFactory: locationFactory)
        return locationCoordinator
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - 20) / 2
        let layoutHeight = (ViewValues.widthScreen - 20) / 2
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        return layout
    }
}
