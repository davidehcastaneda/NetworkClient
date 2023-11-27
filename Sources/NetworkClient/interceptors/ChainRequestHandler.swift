//
//  ChainRequestHandler.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

protocol ChainRequestHandler {
    func call(with request: Request) async throws -> (Data, URLResponse)
}
