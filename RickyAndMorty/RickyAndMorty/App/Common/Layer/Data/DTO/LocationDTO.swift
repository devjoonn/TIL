//
//  LocationDTO.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

struct LocationDTO: Decodable {
    let name: String
    let type: String?
    let dimension: String?
    let url: String
}
