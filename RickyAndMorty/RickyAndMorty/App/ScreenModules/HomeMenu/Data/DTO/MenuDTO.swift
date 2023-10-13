//
//  MenuDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/13/23.
//

struct MenuDTO: Decodable {
    let characters: String
    let locations: String
    let episodes: String
}

extension MenuDTO: PropertyIterator { }
