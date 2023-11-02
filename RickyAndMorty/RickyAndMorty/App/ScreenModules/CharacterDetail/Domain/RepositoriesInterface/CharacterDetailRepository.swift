//
//  CharacterDetailRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/1/23.
//

protocol CharacterDetailRepository {
    func fetchCharacterDetail(urlDetail: String) async throws -> Character
}
