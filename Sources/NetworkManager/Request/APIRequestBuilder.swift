//
//  APIRequestBuilder.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

internal class APIRequestBuilder: APIRequestBuilderProtocol {
    //MARK: Internal Functions
    internal func requestFrom(_ requestable: Requestable) -> URLRequest? {
        let components: [String] = [requestable.host, requestable.version, requestable.path].compactMap({ $0 })

        let urlString: String = "https://" + components.joined(separator: "/")
        
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
    
    //MARK: Private Functions
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
