//
//  ItemCharacterViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

struct ItemCharacterViewModel {
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        character.name
    }
    
    var specie: String {
        character.specie.description
    }
    
    var status: String {
        character.status?.description ?? ""
    }
}
