//
//  ImageDataRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

import Foundation

protocol ImageDataRepository {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: URL?) -> Data?
}
