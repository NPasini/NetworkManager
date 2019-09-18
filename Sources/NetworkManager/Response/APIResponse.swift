//
//  APIResponse.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

class APIResponse {
    let data: Data?
    let statusCode: Int
    let request: URLRequest
    let response: URLResponse?
    
    init(request: URLRequest, response: URLResponse?, data: Data?, statusCode: Int){
        self.data = data
        self.request = request
        self.response = response
        self.statusCode = statusCode
    }
}
