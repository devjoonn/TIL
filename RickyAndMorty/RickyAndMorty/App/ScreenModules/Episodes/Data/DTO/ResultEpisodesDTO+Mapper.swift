//
//  ResultEpisodesDTO+Mapper.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/7/23.
//

extension ResultEpisodesDTO {
    func toDomain() -> (info: Info, episodes: [Episode]) {
        let info = Info(next: info.next)
        let episodes = results.map {
            Episode(
                id: $0.id,
                name: $0.name,
                airDate: $0.airDate,
                episode: $0.episode)
        }
        return (info: info, episodes: episodes)
    }
}
