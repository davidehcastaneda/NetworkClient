//
//  chain.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation
import NetworkRequest

public class Chain {
    init(interceptors: [Interceptor], client: ChainRequestHandler) {
        self.interceptors = interceptors
        self.requestHandler = client
    }

    private let requestHandler: ChainRequestHandler
    private var interceptors: [Interceptor]

    func start(request: NetworkRequest) async throws -> (Data, URLResponse) {
        try await proceed(request: request)
    }

    public func proceed(request: NetworkRequest) async throws -> (Data, URLResponse) {
        guard !interceptors.isEmpty else { return try await requestHandler.call(with: request) }
        return try await interceptors.removeFirst().intercept(request: request, chain: self)
    }
}
