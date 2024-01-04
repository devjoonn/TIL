//
//  CountryTableViewCell.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/9/23.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout

protocol CountryTableViewCellDelegate: AnyObject {
    func checkedButtonTapped(country: Country)
}

class CountryTableViewCell: UITableViewCell {
    static let identifier = "CountryTableViewCell"
    
    var checkedButtonSelected: Bool = false {
        didSet {
            checkedButton.isSelected = checkedButtonSelected
        }
    }
    
    var country: Country? {
        didSet {
            configure()
        }
    }
    
    private let countryImageView: UIImageView = {
        $0.image = UIImage(systemName: "xmark")
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let countryNameLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let checkedButton: UIButton = {
        $0.setTitle("체크", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("체크됨", for: .selected)
        $0.setTitleColor(.red, for: .selected)
        return $0
    }(UIButton())
    
    weak var delegate: CountryTableViewCellDelegate?
    var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        checkedButtonSelected = false
    }
    
    // MARK: - Set UI
    private func addView() {
        contentView.addSubview(countryImageView)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(checkedButton)
    }
    private func setLayout() {
        countryImageView.pin.left(15).vCenter().width(42).height(30)
        countryNameLabel.pin.after(of: countryImageView).height(80%).width(60%).marginLeft(16).vCenter()
        checkedButton.pin.after(of: contentView).marginRight(20).vCenter().height(30).width(20%)
    }
    
    func configure() {
        guard let country = country else { return }
        countryImageView.image = UIImage(systemName: "xmark")
        countryNameLabel.text = country.name
    }
    
    // MARK: - Action
    private func bind() {
        checkedButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self,
                      let country = country else { return }
                self.delegate?.checkedButtonTapped(country: country)
                self.checkedButtonSelected.toggle()
            }.disposed(by: disposeBag)
    }
}
