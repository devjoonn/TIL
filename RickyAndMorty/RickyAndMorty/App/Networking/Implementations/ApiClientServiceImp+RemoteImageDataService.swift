//
//  ApiClientServiceImp+RemoteImageDataService.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/22/23.
//

import Foundation

extension ApiClientServiceImp: RemoteImageDataService {
    func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return  (data: data, request: request).data
        } catch {
            return nil
        }
    }
}
