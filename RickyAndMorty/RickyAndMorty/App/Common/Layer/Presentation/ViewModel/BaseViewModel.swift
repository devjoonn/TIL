//
//  BaseViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/16/23.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}
