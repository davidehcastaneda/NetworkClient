//
//  NetworkClientBuilder.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

public class NetworkClientBuilder {

    private let baseUrl: String
    private var interceptors: [Interceptor] = []
    private var session: URLSession?
    private var decoder: JSONDecoder?
    private var encoder: JSONEncoder?

    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    public func override(_ session: URLSession) -> NetworkClientBuilder {
        self.session = session
        return self
    }

    public func override(_ decoder: JSONDecoder) -> NetworkClientBuilder {
        self.decoder = decoder
        return self
    }

    public func override(_ encoder: JSONEncoder) -> NetworkClientBuilder {
        self.encoder = encoder
        return self
    }

    public func add(_ interceptor: Interceptor) -> NetworkClientBuilder {
        self.interceptors.append(interceptor)
        return self
    }

    public func build() -> NetworkClient {
        NetworkClientV1(
            baseUrl: baseUrl,
            session: session ?? URLSession.shared,
            decoder: decoder ?? JSONDecoder(),
            requestBuilder: RequestBuilderV1(encoder: encoder ?? JSONEncoder()),
            interceptors: interceptors
        )
    }
}
