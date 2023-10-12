//
//  MenuRepositoryImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

struct MenuRepositoryImp: MenuRepository {
    
    func fetchMenuData() async throws -> [MenuItem] {
        [MenuItem(title: "locations", url: "nada")]
    }
}
