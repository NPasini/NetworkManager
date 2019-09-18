//
//  APIRequestProtocols.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

protocol Requestable {
    var body: Data? { get }
    var host: String { get }
    var path: String { get }
    var version: String { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval? { get }
    var headerParameters: HTTPHeaders? { get }
    var bodyParameters: HTTPBodyParameters? { get }
    var queryParameters: HTTPQueryParameters? { get }
}

protocol Validatable {
    associatedtype Object
    
    func validateResponseObject(_ object: Object) -> NSError?
    func validateResponse(_ response: URLResponse) -> NSError?
}

protocol Processable {
    func processRequest(_ urlRequest: URLRequest) -> URLRequest
}

protocol APIRequestBuilderProtocol {
    func requestFrom(_ requestable: Requestable) -> URLRequest?
}

protocol APIRequestPerformerProtocol {
    func performRequest(_ request: URLRequest, completion: @escaping (Result<APIResponse, NSError>) -> Void) -> APISubscriptionProtocol
}

protocol APIRequestPerformerFactoryProtocol {
    func requestPerformerForQoS(_ QoS: QualityOfService) -> APIRequestPerformerProtocol
}
