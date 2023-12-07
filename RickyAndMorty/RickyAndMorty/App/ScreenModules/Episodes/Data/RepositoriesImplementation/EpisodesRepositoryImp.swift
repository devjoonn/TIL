//
//  EpisodesRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/7/23.
//
import Foundation

struct EpisodesRepositoryImp: EpisodesRepository {
    private(set) var remoteService: ApiClientService
    
    func fetch(urlEpisodes: String) async throws -> (info: Info, episodes: [Episode]) {
        let url = URL(string: urlEpisodes)
        return try await remoteService.request(
            url: url,
            type: ResultEpisodesDTO.self)
        .toDomain()
        
    }
}
