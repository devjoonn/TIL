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
        configTableView()
    }
    
    // MARK: - Helpers
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(ItemCharacterTableViewCell.self, forCellReuseIdentifier: ItemCharacterTableViewCell.reuseIdentifier)
    }
}

    //MARK: - TableView DataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCharacterTableViewCell.reuseIdentifier, for: indexPath) as? ItemCharacterTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
