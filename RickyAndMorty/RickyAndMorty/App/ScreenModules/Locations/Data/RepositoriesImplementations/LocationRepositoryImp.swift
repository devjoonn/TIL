//
//  LocationRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/27/23.
//

import Foundation

struct LocationRepositoryImp: LocationsRepository {
    private(set) var remoteServices: ApiClientService
    
    func fetchLocation(urlLocations: String) async throws -> (info: Info, locations: [Location]) {
        let url = URL(string: urlLocations)
        return try await remoteServices.request(url: url, type: ResultLocationDTO.self ).toDomain()
    }
}
