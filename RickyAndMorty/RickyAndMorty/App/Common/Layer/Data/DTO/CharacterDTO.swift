//
//  CharacterDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let image: String?
    let url: String
    let origin: OriginDTO
    let location: LocationDTO
}
