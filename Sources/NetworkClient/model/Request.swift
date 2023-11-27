//
//  Request.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

public struct Request {
    public let path: String
    public let dynamicPathArguments: [String]
    public let method: Method
    public var queryParams: [String: String]
    public var headerParams: [String: String]
    public var body: Encodable?

    public init(
        path: String = "",
        dynamicPathArguments: [String] = [],
        method: Method = .GET,
        queryParams: [String: String] = [:],
        headerParams: [String: String] = [:],
        body: Encodable? = nil
    ) {
        self.path = path
        self.dynamicPathArguments = dynamicPathArguments
        self.method = method
        self.queryParams = queryParams
        self.headerParams = headerParams
        self.body = body
    }
}

extension Request {
    public enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
}
