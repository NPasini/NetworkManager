//
//  APIResponse.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
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
