//
//  ItemLocationTableViewCell.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/28/23.
//

import UIKit

final class ItemLocationTableViewCell: UITableViewCell {
    // MARK: - Properties
    private lazy var nameLabel: UILabel = makeLabels(forTextStyle: .headline)
    private lazy var dimensionLabel: UILabel = makeLabels(forTextStyle: .subheadline)
    private lazy var typeLabel: UILabel = makeLabels(forTextStyle: .footnote)
    
    
    
    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configUserInterface() {
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, dimensionLabel, typeLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        addSubview(stack)
        stack.setConstraints(
            top: topAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            pTop: 10,
            pRight: 10,
            pBottom: 10,
            pLeft: 20
        )
    }
        
    public func configData(viewModel: ItemLocationViewModel) {
        nameLabel.text = viewModel.name
        dimensionLabel.text = viewModel.dimension
        typeLabel.text = viewModel.type
    }
    
    private func makeLabels(forTextStyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
}

extension ItemLocationTableViewCell: Reusable { }
