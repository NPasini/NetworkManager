//
//  APIRequestPerformer.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

internal class APIRequestPerformer: NSObject, URLSessionDelegate, APIRequestPerformerProtocol {
    private var session: URLSession?
    
    internal init(QoS: QualityOfService, timeoutForRequests: TimeInterval = 15) {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutForRequests
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let delegateQueue = OperationQueue()
        delegateQueue.qualityOfService = QoS
        
        super.init()
        
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
    
    internal func performRequest(_ request: URLRequest, completion: @escaping (Result<APIResponse, NSError>) -> Void) -> APISubscriptionProtocol {
        
        var subscription: APISubscriptionProtocol!
        
        let task = session!.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let e = error as NSError? {
                completion(Result.failure(e))
                return
            }
            
            let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            let response = APIResponse(request: request, response: response, data: data, statusCode: statusCode)
            
            completion(Result.success(response))
        }
        
        task.resume()
        
        subscription = APISubscription(task: task)
        
        return subscription
    }
}
