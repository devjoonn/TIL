//
//  ItemLocationViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/28/23.
//

struct ItemLocationViewModel {
    private(set) var location: Location
    
    var name: String {
        location.name
    }
    
    // TODO: - Remove Strings and use AppLocalized
    var dimension: String {
        let safeDimension = location.dimension ?? AppLocalized.unknown
        return "Dimension: \(safeDimension)"
    }
    
    var type: String {
        let safeType = location.type ?? AppLocalized.unknown
        return "Dimension: \(safeType)"
    }
    
}
