//
//  EpisodesViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/2/23.
//

import UIKit
import Combine

final class EpisodesViewController: UITableViewController {
    // MARK: - Properties
    private let viewModel: EpisodesViewModel
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life Cycles
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        stateController()
        addSpinnerLastCell()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        tableView.register(ItemEpisodeTableViewCell.self, forCellReuseIdentifier: ItemEpisodeTableViewCell.reuseIdentifier)
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .success:
                    self?.tableView.reloadData()
                case .loading:
                    break
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }.store(in: &cancellable)
    }
}

extension EpisodesViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemEpisodeTableViewCell.reuseIdentifier, for: indexPath) as? ItemEpisodeTableViewCell else { return UITableViewCell() }
        
        let viewModel = viewModel.getItemEpisodeViewModel(row: indexPath.row)
        cell.configData(viewModel: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsEpisodesCount
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
}

extension EpisodesViewController: MessageDisplayable { }
