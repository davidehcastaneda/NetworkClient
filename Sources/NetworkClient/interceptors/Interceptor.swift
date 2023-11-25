//
//  Interceptor.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

public protocol Interceptor {
    func intercept(request: Request, chain: Chain) async throws -> (Data, URLResponse)
}
