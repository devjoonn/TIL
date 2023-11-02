//
//  CharacterDTO+Mapping.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/1/23.
//

extension CharacterDTO {
    func toDomain() -> Character {
        let statusCharacter = StatusCharacter(status: status)
        let specie = Specie(specie: species)
        let origin = Origin(name: origin.name, url: origin.url)
        let location = Location(name: location.name, 
                                type: location.type,
                                dimension: location.dimension,
                                url: location.url)
        
        return Character(id: id, 
                         name: name,
                         status: statusCharacter,
                         specie: specie,
                         urlCharacter: url,
                         urlImage: image,
                         origin: origin,
                         location: location)
    }
}
