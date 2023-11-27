//
//  NetworkClient.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

public protocol NetworkClient {
    func perform<T: Decodable>(_ request: Request) async throws -> T
}
