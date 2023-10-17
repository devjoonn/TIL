//
//  CharactersRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

protocol CharactersRepository {
    func fetchCharacters(urlList: String) async throws -> (info: Info, character: [Character])
}
