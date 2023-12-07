//
//  ResultEpisodesDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/7/23.
//

struct ResultEpisodesDTO: Decodable {
    let info: InfoDTO
    let results: [EpisodeDTO]
}
