//
//  ChainRequestHandler.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation
import NetworkRequest

protocol ChainRequestHandler {
    func call(with request: NetworkRequest) async throws -> (Data, URLResponse)
}
