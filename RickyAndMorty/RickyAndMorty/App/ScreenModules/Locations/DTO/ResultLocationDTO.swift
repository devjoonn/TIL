//
//  ResultLocationDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/27/23.
//

struct ResultLocationDTO: Decodable {
    let info: InfoDTO
    let results: [LocationDTO]
}
