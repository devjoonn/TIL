//
//  HomeCollectionViewCell.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/17/23.
//

import UIKit
import FlexLayout
import PinLayout

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        $0.backgroundColor = .systemPink
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    private let countryImageView: UIImageView = {
        $0.layer.cornerRadius = 4
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let countryLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let otherCountryLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let stackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
        return $0
    }(UIStackView())
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        dateLabel.text = ""
        countryLabel.text = ""
        countryImageView.image = nil
        otherCountryLabel.text = ""
    }
    
    // MARK: - Set UI
    private func setView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    private func addView() {
        [
            backgroundImageView, 
            titleLabel,
            dateLabel
        ].forEach {
            addSubview($0)
        }
        
        [
            countryImageView,
            countryLabel,
            otherCountryLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        backgroundImageView.addSubview(stackView)
    }
    
    private func setLayout() {
        backgroundImageView.pin.top().left().right().height(61%)
        
        titleLabel.pin.below(of: backgroundImageView).marginTop(14)
            .left(20).height(25).width(90%)
        
        dateLabel.pin.below(of: titleLabel).marginTop(5)
            .left(20).height(23).width(90%)
        
        stackView.pin.bottom(18).left(20).height(50).width(50%)
    }
    
    func configure() {
        titleLabel.text = "유럽 여행 고고링"
        dateLabel.text = "2023년 12월 18일 - 2023년 12월 31일"
        countryLabel.text = "프랑스"
        countryImageView.image = UIImage(systemName: "xmark")
        otherCountryLabel.text = "외 2개국"
    }
}
