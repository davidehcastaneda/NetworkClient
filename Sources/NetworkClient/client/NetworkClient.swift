//
//  NetworkClient.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation
import NetworkRequest

public protocol NetworkClient {
    func perform<T: Decodable>(_ request: NetworkRequest) async throws -> T
}
