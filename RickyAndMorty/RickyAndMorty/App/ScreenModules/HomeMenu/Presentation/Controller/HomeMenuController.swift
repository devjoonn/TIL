//
//  HomeMenuController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/7/23.
//

import UIKit
import Combine

class HomeMenuController: UICollectionViewController {
    // MARK: - Properties
    private let viewModel: HomeMenuViewModel
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life Cycles
    init(viewModel: HomeMenuViewModel, layout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
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
            .sink { state in
            switch state {
            case .success:
                self.collectionView.reloadData()
            case .loading:
                print("loading")
            case .fail(error: let error):
                print("error", error)
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
