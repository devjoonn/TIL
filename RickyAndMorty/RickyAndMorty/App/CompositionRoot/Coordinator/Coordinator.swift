//
//  Coordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/8/23.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
