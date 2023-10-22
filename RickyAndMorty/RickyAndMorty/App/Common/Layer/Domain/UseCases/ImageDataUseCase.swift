//
//  ImageDataUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

import Foundation

protocol ImageDataUseCase {
    func getData(url: URL?) async -> Data?
    func getDataFromCache(url: URL?) -> Data?
}

struct ImageDataUseCaseImp: ImageDataUseCase {
    private(set) var imageDataRepository: ImageDataRepository
    
    func getData(url: URL?) async -> Data? {
        await imageDataRepository.fetchData(url: url)
    }
    
    func getDataFromCache(url: URL?) -> Data? {
        imageDataRepository.getFromCache(url: url)
    }
}
