//
//  AppContainer.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

protocol AppContainer {
    var apiClient: ApiClientService & RemoteImageDataService { get }
    var localDataService: LocalDataImageService { get }
    func getDataImageUseCase() -> ImageDataUseCase
}

struct AppContainerImp: AppContainer {
    var apiClient: ApiClientService & RemoteImageDataService = ApiClientServiceImp()
    
    var localDataService: LocalDataImageService = LocalDataImageServiceImp()
    
    func getDataImageUseCase() -> ImageDataUseCase {
        let imageDataRepository = ImageDataRepositoryImp(
            remoteDataService: apiClient,
            localDataCache: localDataService)
        return ImageDataUseCaseImp(imageDataRepository: imageDataRepository)
    }
}
