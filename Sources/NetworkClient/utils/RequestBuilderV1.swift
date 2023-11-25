//
//  RequestBuilderV2.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

class RequestBuilderV1: RequestBuilder {

    private let encoder: JSONEncoder

    init(encoder: JSONEncoder) {
        self.encoder = encoder
    }

    func create(from baseUrl: String, and baseRequest: Request) throws -> URLRequest {
        return try baseUrl
            .appending(baseRequest.path)
            .substitutingPathParameters(with: baseRequest.dynamicPathArguments)
            .toUrlComponents()
            .plus(queryParams: baseRequest.queryParams)
            .getRequest()
            .define(httpMethod: baseRequest.method.rawValue)
            .forMethod(baseRequest.method, addIfNeeded: baseRequest.body, with: encoder)
            .add(headers: baseRequest.headerParams)
    }
}

private extension String {
    func substitutingPathParameters(with complements: [String]) -> String {
        if complements.isEmpty { return self }
        return String(format: self, arguments: complements)
    }

    func toUrlComponents() throws -> URLComponents {
        guard let components = URLComponents(string: self) else { throw RequestBuilderErrors.invalidUrlFormat(self) }
        return components
    }
}

private extension URLComponents {
    func plus(queryParams: [String: String]) -> URLComponents {
        guard !queryParams.isEmpty else { return self }
        var updated = self
        updated.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        return updated
    }

    func getRequest() throws -> URLRequest {
        guard let safeUrl = url else { throw RequestBuilderErrors.invalidUrlFormat(url?.absoluteString) }
        return URLRequest(url: safeUrl)
    }
}

private extension URLRequest {
    func define(httpMethod: String) -> URLRequest {
        var updated = self
        updated.httpMethod = httpMethod
        return updated
    }

    func forMethod(_ method: Request.Method, addIfNeeded body: Encodable?, with encoder: JSONEncoder) throws -> URLRequest {
        guard method == .POST, let body = body else { return self }
        var updated = self
        updated.httpBody = try encoder.encode(body)
        return updated
    }

    func add(headers: [String: String]) -> URLRequest {
        guard !headers.isEmpty else { return self }
        var updated = self
        headers.forEach { updated.setValue($0.value, forHTTPHeaderField: $0.key) }
        return updated
    }
}

fileprivate enum RequestBuilderErrors: Error {
    case invalidUrlFormat(String?)
}
