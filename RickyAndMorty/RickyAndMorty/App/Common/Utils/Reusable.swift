//
//  Reusable.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

protocol Reusable {}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
