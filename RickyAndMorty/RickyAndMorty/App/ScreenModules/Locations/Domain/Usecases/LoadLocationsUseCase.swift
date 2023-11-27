//
//  LoadLocationsUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/27/23.
//

protocol LoadLocationsUseCase {
    mutating func excute() async -> Result<[Location], Error>
}

struct LoadLocationsUseCaseImp: LoadLocationsUseCase {
    private(set) var locationRepository: LocationsRepository
    private(set) var urlLocations: String
    
    mutating func excute() async -> Result<[Location], Error> {
        guard !urlLocations.isEmpty else { return .success([]) }
        
        do {
            let result = try await locationRepository.fetchLocation(urlLocations: urlLocations)
            urlLocations = result.info.next ?? .empty
            return .success(result.locations)
        } catch {
            return .failure(error)
        }
    }
}
 
