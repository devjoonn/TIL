//
//  CharacterDetailRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/1/23.
//

import Foundation

struct CharacterDetailRepositoryImp: CharacterDetailRepository {
    private(set) var remoteService: ApiClientService
    
    init(remoteService: ApiClientService) {
        self.remoteService = remoteService
    }
    
    func fetchCharacterDetail(urlDetail: String) async throws -> Character {
        let url = URL(string: urlDetail)
        let result = try await remoteService.request(url: url, type: CharacterDTO.self)
        return result.toDomain()
    }
    
}
