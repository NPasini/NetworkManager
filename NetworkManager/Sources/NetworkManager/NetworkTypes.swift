//
//  NetworkTypes.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPBodyParameters = [String: Any]
typealias HTTPQueryParameters = [String: CustomStringConvertible]

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum ContentType: String {
    case json = "application/json"
}

struct APIResponseWrapper<T> where T: CustomDecodable {
    let object: T
    let statusCode: Int
}
