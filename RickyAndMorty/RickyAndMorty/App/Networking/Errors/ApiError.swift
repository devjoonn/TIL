//
//  ApiError.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/12/23.
//

import Foundation

enum ApiError: Error {
    case clientError
    case serverError
    case unownError
    case errorInUrl
    case errorDecoding
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Client Error", comment: "")
        case .serverError:
            return NSLocalizedString("Server Error", comment: "")
        case .unownError:
            return NSLocalizedString("Unown Error", comment: "")
        case .errorInUrl:
            return NSLocalizedString("Error In Url", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Error Decoding", comment: "")
        }
    }
}
