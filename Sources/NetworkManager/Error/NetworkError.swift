//
//  NetworkError.swift
//  
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

private let NetworkManagerDomain: String = "package.networkManager"

public class NetworkError: NSError {
    public convenience init(errorType: ErrorType) {
        self.init(domain: NetworkManagerDomain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey : String(describing: errorType)])
    }
}
