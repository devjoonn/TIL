//
//  CarculatorReactor.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/8/23.
//

import Foundation
import ReactorKit
import RxSwift

final class CarculatorReactor: Reactor {
    
    enum Action {
        case increaseNumber
        case decreaseNumber
        case resetNumber
    }
    
    enum Mutation {
        case increaseNumber
        case decreaseNumber
        case resetNumber
    }
    
    struct State {
        var currentNum: Int = 0
    }
    
    var initialState: State = State()
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increaseNumber:
            return .just(Mutation.increaseNumber)
        case .decreaseNumber:
            return .just(Mutation.decreaseNumber)
        case .resetNumber:
            return .just(Mutation.resetNumber)
        }
    }
    
    // MARK: Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .increaseNumber:
            newState.currentNum += 1
        case .decreaseNumber:
            if newState.currentNum > 0 {
                newState.currentNum -= 1
            }
        case .resetNumber:
            newState.currentNum = 0
        }
        
        return newState
    }
}
