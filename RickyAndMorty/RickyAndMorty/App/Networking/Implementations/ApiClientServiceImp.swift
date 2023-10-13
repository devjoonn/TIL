//
//  ApiClientServiceImp.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/12/23.
//

import Foundation

struct ApiClientServiceImp: ApiClientService {
     
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
     
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T {
        guard let url = url else { throw ApiError.errorInUrl }
        return try await makeRequest(url: url)
    }
    
    private func makeRequest<T: Decodable>(url: URL) async throws -> T {
        let request = try await session.data(from: url)
        return try validateResponse(request: request)
    }
    
    private func validateResponse<T: Decodable>(request: (data: Data, httpResponse: URLResponse)) throws -> T {
        guard let httpResponse = request.httpResponse as? HTTPURLResponse else { throw ApiError.unownError }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decoModel(data: request.data)
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unownError
        }
    }
    
    private func decoModel<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
}
