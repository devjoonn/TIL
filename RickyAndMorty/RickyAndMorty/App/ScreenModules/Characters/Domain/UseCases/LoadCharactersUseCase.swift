//
//  LoadCharactersUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

protocol LoadCharactersUseCase {
    func excute() async -> Result<[Character], Error>
}

final class LoadCharactersUseCaseImp: LoadCharactersUseCase {
    
    private let characterRepository: CharactersRepository
    private var url: String
    private var result: (info: Info, character: [Character])?
    
    init(characterRepository: CharactersRepository, url: String) {
        self.characterRepository = characterRepository
        self.url = url
    }
    
    func excute() async -> Result<[Character], Error> {
        guard !url.isEmpty else { return .success([])}
        do {
            let repositoryResult = try await characterRepository.fetchCharacters(urlList: url)
            url = repositoryResult.info.next ?? .empty
            return .success(repositoryResult.character)
        } catch {
            return .failure(error)
        }
    }
}
