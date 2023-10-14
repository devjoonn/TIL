//
//  CharacterViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit

protocol CharactersViewControllerCoordinator {
    func didSelectMenuCell(urlDetail: String)
}

final class CharactersViewController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
