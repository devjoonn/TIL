//
//  HorizontalContryView.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/9/23.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout

class HorizontalContryView: UIScrollView {
    lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 15
        $0.backgroundColor = .clear
        return $0
    }(UIStackView())
    
    var selectedButton: UIButton?
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented xib init")
    }
    
    // 버튼 탭하고 스크롤 가능하게!
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    private func configure() {
        canCancelContentTouches = true
        showsHorizontalScrollIndicator = false
        bounces = false
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func bind() {
        CountryType.allCases.forEach { type in
            let button: PaddingButton = {
                let btn = PaddingButton(padding: .medium)
                btn.setTitle(type.rawValue, for: .normal)
                btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
                btn.setTitleColor(.gray, for: .normal)
                btn.setBackgroundColor(.systemGray5, for: .normal)
                btn.setTitleColor(.white, for: .highlighted)
                btn.setBackgroundColor(.darkGray, for: .highlighted)
                btn.setTitleColor(.white, for: .selected)
                btn.setBackgroundColor(.darkGray, for: .selected)
                btn.layer.cornerRadius = 17
                btn.clipsToBounds = true
                return btn
            }()
            
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.selectedButton?.isSelected = false
                    self?.selectedButton = button
                    button.isSelected.toggle()
                })
                .disposed(by: disposeBag)
            
            stackView.addArrangedSubview(button)
            
            // 초기 selected 값
            if type == .total {
                button.isSelected = true
                selectedButton = button
            }
        }
    }
}

// button hilighting 색상 처리
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
