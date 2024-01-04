//
//  HomeReactor.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/17/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class HomeReactor: Reactor {
    
    var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeTrip>!
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = State()
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        return newState
    }
    
    func configureSnapshot(data: [HomeTrip]) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeTrip>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
