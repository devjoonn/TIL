//
//  HomeMenuController.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/7/23.
//

import UIKit

class HomeMenuController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configCollectionView()
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
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemHomeMenuCell.reuseIdentifier, for: indexPath) as? ItemHomeMenuCell else { return UICollectionViewCell() }
        return cell
    }
}
