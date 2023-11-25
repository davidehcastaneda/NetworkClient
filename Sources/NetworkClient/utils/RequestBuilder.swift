//
//  RequestBuilder.swift
//  NetworkClient
//
//  Created by David Castaneda on 11/25/23.
//

import Foundation

protocol RequestBuilder {
    func create(from baseUrl: String, and baseRequest: Request) throws -> URLRequest
}
