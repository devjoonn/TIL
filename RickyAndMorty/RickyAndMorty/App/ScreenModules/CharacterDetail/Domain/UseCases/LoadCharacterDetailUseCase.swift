//
//  LoadCharacterDetailUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/1/23.
//

protocol LoadCharacterDetailUseCase {
    func excute() async throws -> Character
}

struct LoadCharacterDetailUseCaseImp: LoadCharacterDetailUseCase {
    private(set) var characterDetailRepository: CharacterDetailRepository
    private(set) var urlDetail: String
    
    func excute() async throws -> Character {
        try await characterDetailRepository.fetchCharacterDetail(urlDetail: urlDetail)
    }
}
