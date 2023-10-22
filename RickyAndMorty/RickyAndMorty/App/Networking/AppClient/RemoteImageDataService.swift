//
//  RemoteImageDataService.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

import Foundation

protocol RemoteImageDataService {
    func request(url: URL?) async -> Data?
}
