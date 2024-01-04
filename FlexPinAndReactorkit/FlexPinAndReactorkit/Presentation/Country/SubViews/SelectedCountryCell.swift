//
//  SelectedCountryCell.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/13/23.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout

protocol SelectedCountryCellDelegate: AnyObject {
    func deleteButtonTapped(country: Country)
}

class SelectedCountryCell: UICollectionViewCell {
    static let identifier = "SelectedCountryCell"
    
    // MARK: - Properties
    var country: Country? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: SelectedCountryCellDelegate?
    
    var disposeBag = DisposeBag()
    
    private let countryNameLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = .boldSystemFont(ofSize: 12)
        return $0
    }(UILabel())
    
    private let countryImageView: UIImageView = {
        $0.image = UIImage(systemName: "xmark")
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let deleteButton: UIButton =  {
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
        return $0
    }(UIButton())
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        countryImageView.image = nil
        countryNameLabel.text = ""
    }
    
    // MARK: - Set UI
    private func addView() {
        contentView.addSubview(countryImageView)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(deleteButton)
    }
    private func setLayout() {
        countryImageView.pin.top(4).left().width(85%).height(50%)
        countryNameLabel.pin.below(of: countryImageView)
            .height(35%)
            .width(100%)
            .hCenter()
            .marginTop(6)
        deleteButton.pin.top().right().height(24).width(24)
    }
    
    func configure() {
        guard let country = country else { return }
        // 이미지 변경
        countryImageView.image = UIImage(systemName: "xmark")
        countryNameLabel.text = country.name
    }
    
    // MARK: - Handler
    private func bind() {
        deleteButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self,
                      let country = country else { return }
                delegate?.deleteButtonTapped(country: country)
            }.disposed(by: disposeBag)
    }
}
