//
//  CarculatorController.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/8/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

final class CarculatorController: UIViewController {
    
    var disposeBag = DisposeBag()
    let reactor: CarculatorReactor
    // MARK: - Properties
    private let rootFlexContainer = UIView()
    
    let numLabel: UILabel = {
        $0.text = "0"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    let increaseButton: UIButton = {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 25)
        return $0
    }(UIButton())
    
    let decreaseButton: UIButton = {
        $0.setTitle("-", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 25)
        return $0
    }(UIButton())
    
    let resetButton: UIButton = {
        $0.setTitle("reset", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 25)
        return $0
    }(UIButton())
    
    let deleteButton: UIButton = {
        $0.setImage(UIImage(systemName: "xmark")?
            .withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return $0
    }(UIButton())
    
    // MARK: - Life Cycles
    init(reactor: CarculatorReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        setLayouts()
        bind(reactor: reactor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.all(view.pin.safeArea)
        rootFlexContainer.flex.layout()
    }
    
    // MARK: - Set UI
    func addViews() {
        view.addSubview(rootFlexContainer)
        rootFlexContainer.backgroundColor = .systemGray5
    }
    
    func setLayouts() {
        rootFlexContainer.flex.define { flex in
            flex.addItem().justifyContent(.spaceEvenly).height(UIScreen.main.bounds.height * 0.3).alignItems(.center).define { flex in
                flex.backgroundColor(.systemMint)
                flex.addItem(deleteButton).position(.absolute).top(5).right(5).size(55)
                flex.addItem(numLabel).width(250)
                flex.addItem(increaseButton).width(UIScreen.main.bounds.width)
                flex.addItem(decreaseButton).width(UIScreen.main.bounds.width)
                flex.addItem(resetButton).width(UIScreen.main.bounds.width)
            }
        }
    }
}

extension CarculatorController: View {
    // MARK: - Bind
    func bind(reactor: CarculatorReactor) {
        deleteButton.rx.tap
            .bind { [ weak self] _ in
                let controller = CountryViewController(reactor: CountryReactor())
                self?.navigationController?.pushViewController(controller, animated: true)
            }.disposed(by: disposeBag)
        
        increaseButton.rx.tap
            .map { _ in
                Reactor.Action.increaseNumber
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { _ in
                Reactor.Action.decreaseNumber
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .map { _ in
                Reactor.Action.resetNumber
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { String($0.currentNum) }
            .bind(to: numLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
