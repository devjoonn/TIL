//
//  EpisodeDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/7/23.
//

struct EpisodeDTO: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}
