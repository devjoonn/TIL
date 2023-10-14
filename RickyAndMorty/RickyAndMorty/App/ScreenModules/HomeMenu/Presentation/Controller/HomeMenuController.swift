//
//  HomeMenuController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/7/23.
//

import UIKit
import Combine

protocol HomeMenuControllerCoordinator: AnyObject {
    func didSelectMenuCell(model: MenuItem)
}

class HomeMenuController: UICollectionViewController {
    // MARK: - Properties
    private let viewModel: HomeMenuViewModel
    private var cancellable = Set<AnyCancellable>()
    private weak var coordinator: HomeMenuControllerCoordinator?
    
    // MARK: - Life Cycles
    init(viewModel: HomeMenuViewModel, layout: UICollectionViewFlowLayout, coordinator: HomeMenuControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configCollectionView()
        setController()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    private func setController() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.collectionView.reloadData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: AppLocalized.error)
                }
            }.store(in: &cancellable)
    }

    private func configUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configCollectionView() {
        collectionView.register(ItemHomeMenuCell.self, forCellWithReuseIdentifier: ItemHomeMenuCell.reuseIdentifier)
    }
}

extension HomeMenuController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuItemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemHomeMenuCell.reuseIdentifier, for: indexPath) as? ItemHomeMenuCell else { return UICollectionViewCell() }
        
        let viewModelCell = viewModel.getItemMenuViewModel(indexPath: indexPath)
        cell.configData(viewModel: viewModelCell)
        
        return cell
    }
}

extension HomeMenuController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.getMenuItem(indexPath: indexPath)
        coordinator?.didSelectMenuCell(model: model)
    }
}

extension HomeMenuController: SpinnerDisplayable { }

extension HomeMenuController: MessageDisplayable { }
