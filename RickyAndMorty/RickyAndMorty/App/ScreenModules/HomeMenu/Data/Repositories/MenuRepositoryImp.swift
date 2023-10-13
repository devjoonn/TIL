//
//  MenuRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

import Foundation

struct MenuRepositoryImp: MenuRepository {
    
    let apiClientService: ApiClientService
    let urlList: String
    
    func fetchMenuData() async throws -> [MenuItem] {
        let url = URL(string: urlList)
        return try await apiClientService.request(url: url, type: MenuDTO.self).toDomain()
    }
}
