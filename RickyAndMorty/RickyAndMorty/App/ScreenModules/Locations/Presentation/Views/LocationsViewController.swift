//
//  LocationsViewController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/26/23.
//

import UIKit
import Combine

final class LocationsViewController: UITableViewController {
    // MARK: - Properties
    private let viewModel: LocationViewModel
    private var cancellable = Set<AnyCancellable>()
    // MARK: - Life Cycles
    init(viewModel: LocationViewModel) {
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
        tableView.register(ItemLocationTableViewCell.self,
                           forCellReuseIdentifier: ItemLocationTableViewCell.reuseIdentifier)
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

// MARK: - DataSource
extension LocationsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemLocationTableViewCell.reuseIdentifier, for: indexPath) as? ItemLocationTableViewCell else { return UITableViewCell() }
        
        let viewModel = viewModel.getItemLocationViewModel(row: indexPath.row)
        cell.configData(viewModel: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsLocationCount
    }
    
    // 무한 스크롤 시 
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
}

// MARK: - Extensions
extension LocationsViewController: MessageDisplayable { }
