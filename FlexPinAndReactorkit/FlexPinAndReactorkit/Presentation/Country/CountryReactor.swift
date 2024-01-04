//
//  CountryReactor.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/9/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class CountryReactor: Reactor {
    
    var dataSource: UITableViewDiffableDataSource<CountrySection, Country>!
    
    enum Action {
        case searchBarText(text: String)
        case typeButtonTapped(title: String)
        case checkedButtonTapped(country: Country)
        case deletedCountry(country: Country)
        case nextButtonTapped
    }
    
    enum Mutation {
        case searchBarText(text: String)
        case typeButtonTapped(title: String)
        case checkedButtonTapped(country: Country)
        case deletedCountry(country: Country)
        case nextButtonTapped
    }
    
    struct State {
        var selectedCountries: [Country] = []
        var deletedCountry: Country?
    }
    
    var initialState: State = State()
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchBarText(text: let text):
            return .just(Mutation.searchBarText(text: text))
        case .typeButtonTapped(title: let title):
            return .just(Mutation.typeButtonTapped(title: title))
        case .checkedButtonTapped(country: let country):
            return .just(Mutation.checkedButtonTapped(country: country))
        case .deletedCountry(country: let country):
            return .just(Mutation.deletedCountry(country: country))
        case .nextButtonTapped:
            return .just(Mutation.nextButtonTapped)
        }
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .searchBarText(text: let text):
            // 검색 api 받기
            print(text)
        case .typeButtonTapped(title: let title):
            // 데이터 api 받기
            CountryType.allCases.forEach {
                if title == $0.rawValue {
                    configureSnapshot(type: $0, data: $0.getCountries())
                }
            }
        case .checkedButtonTapped(country: let country):
            if let selectedCountryIndex = newState.selectedCountries.firstIndex(where: { $0.name == country.name }) {
                newState.selectedCountries.remove(at: selectedCountryIndex)
            } else {
                newState.selectedCountries.append(country)
            }
        case .deletedCountry(country: let country):
            if let selectedCountryIndex = newState.selectedCountries.firstIndex(where: { $0.name == country.name }) {
                newState.selectedCountries.remove(at: selectedCountryIndex)
                newState.deletedCountry = country
            }
        case .nextButtonTapped:
            print("next 찍힘")
            break
        }
        return newState
    }
    
    func configureSnapshot(type: CountryType = .total, data: [Country]) {
        var snapshot = NSDiffableDataSourceSnapshot<CountrySection, Country>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func unSelectedCountry(country: Country) {
        let action = Action.deletedCountry(country: country)
        _ = self.mutate(action: action)
    }
}
