//
//  LocationsRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/27/23.
//

protocol LocationsRepository {
    func fetchLocation(urlLocations: String) async throws -> (info: Info, locations: [Location])
}
