//
//  CalendarViewController.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/16/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

final class CalendarViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    // MARK: - Properties
    private let calendarFlexContainer = UIView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addViews()
        setLayouts()
//        bind(reactor: reactor)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarFlexContainer.pin.all(view.pin.safeArea)
        calendarFlexContainer.flex.layout()
    }
    
    // MARK: - Set UI
    private func addViews() {
        view.addSubview(calendarFlexContainer)
    }
    
    private func setLayouts() {
        calendarFlexContainer.flex.define { flex in
            
        }
    }
    
}

//extension CalendarViewController: View {
//    func bind(reactor: MainReactor) {
//        bindAction(reactor: reactor)
//        bindState(reactor: reactor)
//    }
//    
//    // MARK: - Bind
//    func bindAction(reactor: MainReactor) {
//        
//    }
//    
//    func bindState(reactor: MainReactor) {
//        
//    }
//}
