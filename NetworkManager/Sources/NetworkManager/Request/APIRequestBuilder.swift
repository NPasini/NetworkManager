//
//  APIRequestBuilder.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

class APIRequestBuilder: APIRequestBuilderProtocol {
    func requestFrom(_ requestable: Requestable) -> URLRequest? {
        
        let urlString: String = "https://\(requestable.host)\(requestable.version)\(requestable.path)"
        
        guard let url: URL = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = requestable.method.rawValue
        request.timeoutInterval = requestable.timeout ?? 15
        
        addHeaderParameters(from: requestable, to: &request)
        addBody(from: requestable, to: &request)
        addQueryParameters(from: requestable, with: url, to: &request)
        
        return request
    }
    
    private func addHeaderParameters(from requestable: Requestable, to request: inout URLRequest) {
        if let headers = requestable.headerParameters {
            for (key, value) in headers {
                request.allHTTPHeaderFields?[key] = value
            }
        }
    }
    
    private func addBody(from requestable: Requestable, to request: inout URLRequest) {
        if let body: Data = requestable.body {
            request.httpBody = body
        }
    }
    
    private func addQueryParameters(from requestable: Requestable, with url: URL, to request: inout URLRequest) {
        if let queryParameters: HTTPQueryParameters = requestable.queryParameters,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let queryItems: [URLQueryItem] = queryParameters.reduce([URLQueryItem]()) { (result: [URLQueryItem], tuple: (key: String, value: CustomStringConvertible)) -> [URLQueryItem] in
                
                let currentQueryItem: [URLQueryItem]
                
                let parameterName: String = tuple.key
                
                if let arrayOfParameters: [CustomStringConvertible] = tuple.value as? [CustomStringConvertible] {
                    currentQueryItem = arrayOfParameters.map { (convertible: CustomStringConvertible) -> URLQueryItem in
                        return URLQueryItem(name: parameterName, value: String(describing: convertible))
                    }
                } else {
                    currentQueryItem = [URLQueryItem(name: parameterName, value: String(describing: tuple.value))]
                }
                
                return result + currentQueryItem
            }
            
            components.queryItems = queryItems
            
            request.url = components.url
        }
    }
}
