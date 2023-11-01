//
//  CharacterDetailViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/29/23.
//

import UIKit

protocol CharacterDetailViewControllerCoordinator {
    
}

final class CharacterDetailViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        
    }
    
    // MARK: - Helper
    func configUserInterface() {
        view.backgroundColor = .systemBackground
    }
    
}
 

