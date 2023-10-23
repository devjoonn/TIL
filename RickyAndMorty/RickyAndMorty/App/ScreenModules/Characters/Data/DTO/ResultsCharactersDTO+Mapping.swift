//
//  ResultsCharactersDTO+Mapping.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

extension ResultsCharactersDTO {
    func toDomain() -> (info: Info, character: [Character]) {
        let characterModel = results.map {
            let statusCharacter = StatusCharacter(status: $0.status)
            let specie = Specie(specie: $0.species)
            let origin = Origin(name: $0.origin.name, url: $0.origin.url)
            let location = Location(name: $0.location.name,
                                    type: $0.location.type,
                                    dimension: $0.location.dimension,
                                    url: $0.location.url)
            return Character(id: $0.id,
                                      name: $0.name,
                                      status: statusCharacter,
                                      specie: specie,
                                      urlCharacter: $0.url,
                                      urlImage: $0.image,
                                      origin: origin,
                                      location: location )
        }
        let info = Info(next: info.next)
        
        return (info: info, character: characterModel)
    }
 }
