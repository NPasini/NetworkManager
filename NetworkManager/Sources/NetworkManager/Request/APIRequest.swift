//
//  APIRequest.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

class APIRequest<T>: Requestable, Validatable, Processable where T: CustomDecodable {
    let host: String
    let path: String
    let version: String
    let method: HTTPMethod
    let timeout: TimeInterval?
    let headerParameters: HTTPHeaders?
    let bodyParameters: HTTPBodyParameters?
    let queryParameters: HTTPQueryParameters?
    
    var body: Data? {
        get {
            return nil
        }
    }
    
    init(host: String,
         path: String,
         version: String,
         method: HTTPMethod,
         timeout: TimeInterval? = nil,
         headerParameters: HTTPHeaders? = nil,
         bodyParameters: HTTPBodyParameters? = nil,
         queryParameters: HTTPQueryParameters? = nil) {
        
        self.host = host
        self.path = path
        self.method = method
        self.version = version
        self.timeout = timeout
        self.bodyParameters = bodyParameters
        self.queryParameters = queryParameters
        
        let baseParameters: HTTPHeaders = [:]
        
        if let additionalParameters = headerParameters {
            self.headerParameters = additionalParameters.reduce(baseParameters) { (result: HTTPHeaders, tuple: (key: String, value: String)) -> HTTPHeaders in
                
                var tmp: HTTPHeaders = result
                
                tmp[tuple.key] = tuple.value
                
                return tmp
            }
        } else {
            self.headerParameters = baseParameters
        }
    }
    
    func validateResponse(_ response: URLResponse) -> NSError? {
        return nil
    }
    
    func validateResponseObject(_ object: T) -> NSError? {
        return nil
    }
    
    func processRequest(_ request: URLRequest) -> URLRequest {
        return request
    }
}

class GetRequest<T>: APIRequest<T> where T: CustomDecodable {
    init(host: String,
         path: String,
         version: String,
         timeout: TimeInterval? = nil,
         headerParameters: HTTPHeaders? = nil,
         bodyParameters: HTTPBodyParameters? = nil,
         queryParameters: HTTPQueryParameters? = nil) {
        
        super.init(host: host, path: path, version: version, method: HTTPMethod.get, timeout: timeout, headerParameters: headerParameters, bodyParameters: bodyParameters, queryParameters: queryParameters)
    }
}
