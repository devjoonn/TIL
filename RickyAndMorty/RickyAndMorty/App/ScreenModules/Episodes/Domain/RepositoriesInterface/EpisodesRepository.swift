//
//  EpisodesRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/7/23.
//

protocol EpisodesRepository {
    func fetch(urlEpisodes: String) async throws -> (info: Info, episodes: [Episode])
}
