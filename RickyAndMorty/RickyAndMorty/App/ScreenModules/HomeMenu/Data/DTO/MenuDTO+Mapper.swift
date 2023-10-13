//
//  MenuDTO+Mapper.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/13/23.
//

extension MenuDTO {
    func toDomain() -> [MenuItem] {
        return self.dictionaryProperties().map { dictionary in
            let title = dictionary.key
            let url: String = (dictionary.value as? String) ?? ""
            return MenuItem(title: title, url: url)
        }
    }
}
