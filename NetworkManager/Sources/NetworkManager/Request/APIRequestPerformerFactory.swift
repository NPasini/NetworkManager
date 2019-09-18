//
//  APIRequestPerformerFactory.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

class APIRequestPerformerFactory: APIRequestPerformerFactoryProtocol {
    static let shared = APIRequestPerformerFactory()
    
    private var requestPerformerMemorizer: [QualityOfService: APIRequestPerformerProtocol]
    
    private init() {
        requestPerformerMemorizer = [:]
    }
    
    func requestPerformerForQoS(_ QoS: QualityOfService) -> APIRequestPerformerProtocol {
        lock()
        
        defer{
            unlock()
        }
        
        if let existingPerformer = requestPerformerMemorizer[QoS] {
            return existingPerformer
        }
        
        let newPerformer = APIRequestPerformer(QoS: QoS)
        requestPerformerMemorizer[QoS] = newPerformer
        return newPerformer
    }
    
    private func lock() {
        objc_sync_enter(self)
    }
    
    private func unlock() {
        objc_sync_exit(self)
    }
}
