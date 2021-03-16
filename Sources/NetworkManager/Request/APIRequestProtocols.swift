//
//  APIRequestProtocols.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

internal protocol Requestable {
    var body: Data? { get }
    var host: String { get }
    var path: String { get }
    var version: String? { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval? { get }
    var headerParameters: HTTPHeaders? { get }
    var bodyParameters: HTTPBodyParameters? { get }
    var queryParameters: HTTPQueryParameters? { get }
}

internal protocol Validatable {
    associatedtype Object
    
    func validateResponseObject(_ object: Object) -> NSError?
    func validateResponse(_ response: URLResponse) -> NSError?
}

internal protocol Processable {
    func processRequest(_ urlRequest: URLRequest) -> URLRequest
}

internal protocol APIRequestBuilderProtocol {
    func requestFrom(_ requestable: Requestable) -> URLRequest?
}

internal protocol APIRequestPerformerProtocol {
    func performRequest(_ request: URLRequest, completion: @escaping (Result<APIResponse, NSError>) -> Void) -> APISubscriptionProtocol
}

internal protocol APIRequestPerformerFactoryProtocol {
    func requestPerformerForQoS(_ QoS: QualityOfService) -> APIRequestPerformerProtocol
}
