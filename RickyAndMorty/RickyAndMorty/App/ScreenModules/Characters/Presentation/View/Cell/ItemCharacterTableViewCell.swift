//
//  ItemCharacterTableViewCell.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit

final class ItemCharacterTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.setHeightConstraint(with: 100)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setWidthConstraint(with: 100)
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textColor = .systemBlue
        label.text = "Rick"
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "Human"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "👾"
        return label
    }()
    
    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUI() {
        selectionStyle = .none
        addSubview(mainContainerView)
        mainContainerView.setConstraints(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor,
                                         pRight: 10, pBottom: 10, pLeft: 10)
        
        mainContainerView.addSubview(characterImageView)
        characterImageView.setConstraints(top: mainContainerView.topAnchor,
                                          bottom: mainContainerView.bottomAnchor,
                                          left: mainContainerView.leftAnchor)
        
        mainContainerView.addSubview(labelContainerStackView)
        labelContainerStackView.setConstraints(top: mainContainerView.topAnchor,
                                               right: mainContainerView.rightAnchor,
                                               bottom: mainContainerView.bottomAnchor,
                                               left: characterImageView.rightAnchor,
                                               pTop: 10, pRight: 10, pBottom: 10, pLeft: 10)
        
        [nameLabel, specieLabel, statusLabel].forEach {
            labelContainerStackView.addArrangedSubview($0)
        }
    }
    
    func configData(viewModel: ItemCharacterViewModel) {
        nameLabel.text = viewModel.name
        specieLabel.text = viewModel.specie
        statusLabel.text = viewModel.status
    }
}

extension ItemCharacterTableViewCell: Reusable {}
