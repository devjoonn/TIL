//
//  ItemHomeMenuCell.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//

import UIKit

final class ItemHomeMenuCell: UICollectionViewCell {
    
    // MARK: - Properties
    let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUI() {
        addSubview(mainContainer)
        mainContainer.fillSuperView(widthPadding: 10)
    }
    
}

extension ItemHomeMenuCell: Reusable { }
