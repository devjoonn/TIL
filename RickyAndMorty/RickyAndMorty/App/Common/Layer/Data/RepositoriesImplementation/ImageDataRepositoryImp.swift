//
//  ImageDataRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

import Foundation

struct ImageDataRepositoryImp: ImageDataRepository {
    private(set) var remoteDataService: RemoteImageDataService
    private(set) var localDataCache: LocalDataImageService
    
    init(remoteDataService: RemoteImageDataService, localDataCache: LocalDataImageService) {
        self.remoteDataService = remoteDataService
        self.localDataCache = localDataCache
    }
    
    func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataService.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    func getFromCache(url: String?) -> Data? {
        localDataCache.get(key: url ?? .empty)
    }
}
