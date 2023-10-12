//
//  MenuRepository.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

protocol MenuRepository {
    func fetchMenuData() async throws -> [MenuItem]
}
