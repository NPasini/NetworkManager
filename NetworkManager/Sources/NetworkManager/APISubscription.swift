//
//  APISubscription.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
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
