//
//  NetworkTypes.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
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
