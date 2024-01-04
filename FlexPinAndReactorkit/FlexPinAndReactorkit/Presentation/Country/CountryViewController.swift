//
//  CountryViewController.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/9/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

enum CountrySection: CaseIterable {
    case main
}

final class CountryViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let reactor: CountryReactor
    // MARK: - Properties
    private let rootFlexContainer = UIView()
    let countryTableView: UITableView = {
        $0.separatorInset.left = 0
        $0.rowHeight = 50
        return $0
    }(UITableView())
    let horizontalContryView = HorizontalContryView()
    let selectedCountryView = SelectedCountryView()
    // MARK: - Life Cycles
    init(reactor: CountryReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavSearchBar()
        addViews()
        setLayouts()
        setDelegate()
        setDataSource()
        bind(reactor: reactor)
        // 초기 데이터 임시
        reactor.configureSnapshot(type: .total, data: CountryType.total.getCountries())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.all(view.pin.safeArea)
        rootFlexContainer.flex.layout()
    }
    
    // MARK: - Set UI
    private func addViews() {
        view.addSubview(rootFlexContainer)
    }
    
    private func setLayouts() {
        rootFlexContainer.flex.define { flex in
            flex.addItem(horizontalContryView).height(70)
            flex.addItem(countryTableView).height(65%).backgroundColor(.systemGray6)
            flex.addItem(selectedCountryView)
        }
    }
    
    private func setDelegate() {
        selectedCountryView.selectedCountryViewDelegate = self
    }
    
    private func setNavSearchBar() {
        let sc = UIScreen.main.bounds.width
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: sc, height: 0))
        searchBar.placeholder = "여행을 떠날 국가명을 입력해주세요."
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func setDataSource() {
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        reactor.dataSource = UITableViewDiffableDataSource<CountrySection, Country>(tableView: self.countryTableView) { (tableView: UITableView, indexPath: IndexPath, country: Country) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.country = country
            
            if self.reactor.currentState.selectedCountries.contains(where: { $0.name == country.name }) {
                cell.checkedButtonSelected = true
            }
            return cell
        }
        countryTableView.dataSource = reactor.dataSource
    }
}

extension CountryViewController: View {
    func bind(reactor: CountryReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Bind
    func bindAction(reactor: CountryReactor) {
        if let searchBar = self.navigationItem.rightBarButtonItem?.customView as? UISearchBar {
            searchBar.rx.text
                .map { Reactor.Action.searchBarText(text: $0 ?? "") }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
        
        for button in horizontalContryView.stackView.arrangedSubviews {
            if let button = button as? UIButton {
                button.rx.tap
                    .map { Reactor.Action.typeButtonTapped(title: button.title(for: .normal) ?? "") }
                    .bind(to: reactor.action)
                    .disposed(by: disposeBag)
            }
        }
        
        selectedCountryView.nextButton.rx.tap
            .bind { [weak self] _ in
                reactor.action.onNext(Reactor.Action.nextButtonTapped)
                let vc = HomeViewController(reactor: HomeReactor())
//                let vc = CalendarViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
    func bindState(reactor: CountryReactor) {
        reactor.state
            .map { $0.selectedCountries }
            .observe(on: MainScheduler.instance)
            .bind(to: selectedCountryView.rx.selectedCountries)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.deletedCountry }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] country in
                guard let country = country,
                      let self = self else { return }
                
                if let visibleCells = self.countryTableView.visibleCells as? [CountryTableViewCell] {
                    for cell in visibleCells {
                        if cell.country == country {
                            cell.checkedButtonSelected = false
                        }
                    }
                }
            }.disposed(by: disposeBag)
    }
    
    private func getSectionIndex(for type: CountryType) -> Int {
        switch type {
        case .total:
            return 0
        case .europe:
            return 1
        case .asia:
            return 2
        case .northAmerica:
            return 3
        case .southAmerica:
            return 4
        case .africa:
            return 5
        }
    }
}

// MARK: - CountryTableViewCellDelegate
extension CountryViewController: CountryTableViewCellDelegate {
    func checkedButtonTapped(country: Country) {
        reactor.action.onNext(.checkedButtonTapped(country: country))
    }
}

// MARK: - SelectedCountryViewDelegate
extension CountryViewController: SelectedCountryViewDelegate {
    func deleteCountry(country: Country) {
        reactor.action.onNext(.deletedCountry(country: country))
    }
}
