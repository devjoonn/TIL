//
//  HomeTrip.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/17/23.
//

import Foundation

enum HomeTripDummy: String, CaseIterable {
    case home
    
    func getTrips() -> [HomeTrip] {
        switch self {
        case .home:
            return Self.tripData
        }
    }
    
    private static let tripData: [HomeTrip] = [
        HomeTrip(countries: ["프랑스","대한민국","일본"], imageURL: "abc", title: "유럽 여행기", startDate: "2023년 12월 08일", endDate: "2023년 12월 17일"),
        HomeTrip(countries: ["말레이시아","대만","일본"], imageURL: "abc", title: "말레이시아", startDate: "2023년 11월 09일", endDate: "2023년 11월 17일"),
        HomeTrip(countries: ["일본"], imageURL: "abc", title: "일본여행", startDate: "2023년 10월 05일", endDate: "2023년 10월 08일")
    ]
    
}

struct HomeTrip: Hashable, Equatable {
    var countries: [String]
    var imageURL: String
    var title: String
    var startDate: String
    var endDate: String
}
