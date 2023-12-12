//
//  LoadEpisodesUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/8/23.
//

protocol LoadEpisodesUseCase {
    mutating func excute() async -> Result<[Episode], Error>
}

struct LoadEpisodesUseCaseImp: LoadEpisodesUseCase {
    private(set) var episodeRepository: EpisodesRepository
    private(set) var urlEpisodes: String
    
    mutating func excute() async -> Result<[Episode], Error> {
        guard !urlEpisodes.isEmpty else { return .success([])}
        do {
            let result = try await episodeRepository
                .fetch(urlEpisodes: urlEpisodes)
            urlEpisodes = result.info.next ?? .empty
            return .success(result.episodes)
        } catch {
            return .failure(error)
        }
    }
}
