//
//  APISubscription.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation
import ReactiveSwift

class APISubscription: APISubscriptionProtocol {
    private let disposable: AnyDisposable
    private let dataTask: URLSessionDataTask
    
    init(task: URLSessionDataTask){
        self.disposable = AnyDisposable{
            task.cancel()
        }
        
        self.dataTask = task
    }
    
    func start(){
        self.dataTask.resume()
    }
    
    func dispose() {
        disposable.dispose()
    }
    
    var isDisposed: Bool {
        get {
            return disposable.isDisposed
        }
    }
}
