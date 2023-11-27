//
//  Interceptor.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation
import NetworkRequest

public protocol Interceptor {
    func intercept(request: NetworkRequest, chain: Chain) async throws -> (Data, URLResponse)
}
