//
//  APIRequest.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

open class APIRequest<T>: Requestable, Validatable, Processable where T: CustomDecodable {
    public let host: String
    public let path: String
    public let version: String
    public let method: HTTPMethod
    public let timeout: TimeInterval?
    public let headerParameters: HTTPHeaders?
    public let bodyParameters: HTTPBodyParameters?
    public let queryParameters: HTTPQueryParameters?
    
    public var body: Data? {
        get {
            return nil
        }
    }
    
    public init(host: String,
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
    
    open func validateResponse(_ response: URLResponse) -> NSError? {
        return nil
    }
    
    open func validateResponseObject(_ object: T) -> NSError? {
        return nil
    }
    
    open func processRequest(_ request: URLRequest) -> URLRequest {
        return request
    }
}

open class GetRequest<T>: APIRequest<T> where T: CustomDecodable {
    public init(host: String,
         path: String,
         version: String,
         timeout: TimeInterval? = nil,
         headerParameters: HTTPHeaders? = nil,
         bodyParameters: HTTPBodyParameters? = nil,
         queryParameters: HTTPQueryParameters? = nil) {
        
        super.init(host: host, path: path, version: version, method: HTTPMethod.get, timeout: timeout, headerParameters: headerParameters, bodyParameters: bodyParameters, queryParameters: queryParameters)
    }
}
