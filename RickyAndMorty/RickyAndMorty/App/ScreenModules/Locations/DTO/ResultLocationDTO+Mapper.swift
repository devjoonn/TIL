//
//  ResultLocationDTO+Mapper.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/27/23.
//

extension ResultLocationDTO {
    func toDomain() -> (info: Info, locations: [Location]) {
        let info = Info(next: info.next)
        let location = results.map {
            Location(name: $0.name, type: $0.type, dimension: $0.dimension, url: $0.url)
        }
        return (info: info, locations: location)
    }
}
