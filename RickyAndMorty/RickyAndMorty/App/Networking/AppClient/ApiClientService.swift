//
//  ApiClientService.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/12/23.
//
import Foundation

protocol ApiClientService {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}
