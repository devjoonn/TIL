//
//  CharacterViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit
import Combine

protocol CharactersViewControllerCoordinator {
    func didSelectMenuCell(urlDetail: String)
}

final class CharactersViewController: UITableViewController {
    
    // MARK: - Properties
    private let viewModel: CharactersViewModel
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life Cycles
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.viewDidLoad()
        configTableView()
        setController()
    }
    
    // MARK: - Helpers
    private func setController() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.tableView.reloadData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    print("Error: \(error)")
                }
            }.store(in: &cancellable)
    }
    
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(ItemCharacterTableViewCell.self, forCellReuseIdentifier: ItemCharacterTableViewCell.reuseIdentifier)
        addSpinnerLastCell()
    }
}

    //MARK: - TableView DataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCharactersCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCharacterTableViewCell.reuseIdentifier, for: indexPath) as? ItemCharacterTableViewCell else { return UITableViewCell() }
        
        let itemViewModel = viewModel.getItemMenuViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !viewModel.lastPage {
            tableView.tableFooterView?.isHidden = false
        } else {
            tableView.tableFooterView?.isHidden = true
        }
    }
}

extension CharactersViewController: SpinnerDisplayable {}
