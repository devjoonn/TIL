//
//  HttpResponseStatus.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/12/23.
//

enum HttpResponseStatus {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
    
}
