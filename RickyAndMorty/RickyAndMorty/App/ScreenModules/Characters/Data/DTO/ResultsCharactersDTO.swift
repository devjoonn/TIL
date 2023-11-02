//
//  ResultsCharactersDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

struct ResultsCharactersDTO: Decodable {
    let results: [CharacterDTO]
    let info: InfoDTO
}
