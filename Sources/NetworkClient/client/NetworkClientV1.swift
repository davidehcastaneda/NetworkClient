//
//  NetworkClientV1.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

class NetworkClientV1: NetworkClient, ChainRequestHandler {

    private let baseUrl: String
    private let session: URLSession
    private let requestBuilder: RequestBuilder
    private let interceptors: [Interceptor]
    private let decoder: JSONDecoder

    init(
        baseUrl: String,
        session: URLSession,
        decoder: JSONDecoder,
        requestBuilder: RequestBuilder,
        interceptors: [Interceptor]
    ) {
        self.baseUrl = baseUrl
        self.session = session
        self.requestBuilder = requestBuilder
        self.interceptors = interceptors
        self.decoder = decoder
    }

    func perform<T>(_ baseRequest: Request) async throws -> T where T: Decodable {
        let result = try await Chain(interceptors: interceptors, client: self).start(request: baseRequest)
        return try decoder.decode(T.self, from: result.0)
    }

    func call(with request: Request) async throws -> (Data, URLResponse) {
        let urlRequest: URLRequest = try requestBuilder.create(from: baseUrl, and: request)
        return try await session.data(for: urlRequest)
    }
}
