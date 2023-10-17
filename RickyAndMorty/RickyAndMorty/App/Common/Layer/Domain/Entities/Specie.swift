//
//  Specie.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

enum Specie {
    case alien
    case human
    case other(type: String?)
    
    init(specie: String?) {
        switch specie {
        case AppLocalized.alien:
            self = .alien
        case AppLocalized.human:
            self = .human
        default:
            self = .other(type: specie)
        }
    }
}

extension Specie: CustomStringConvertible {
    var description: String {
        switch self {
        case .alien:
            return AppLocalized.specieAlien
        case .human:
            return AppLocalized.specieHuman
        case .other(type: let type):
            return "\(AppLocalized.specie) \(String(describing: type))"
        }
    }
}
