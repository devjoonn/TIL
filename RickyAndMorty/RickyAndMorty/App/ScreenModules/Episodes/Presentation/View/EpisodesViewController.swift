//
//  EpisodesViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/2/23.
//

import UIKit
import Combine

final class EpisodesViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
    }
}

