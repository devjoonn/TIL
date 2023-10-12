//
//  LoadMenuUseCase.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

protocol LoadMenuUseCase {
    func excute() async -> Result<[MenuItem], Error>
}

struct LoadMenuUseCaseImp: LoadMenuUseCase {
    let menuRepository: MenuRepository
    
    func excute() async -> Result<[MenuItem], Error> {
        do {
            let repositoryResult = try await menuRepository.fetchMenuData()
            return .success(repositoryResult)
        } catch {
            return .failure(error)
        }
    }
}
