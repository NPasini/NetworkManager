//
//  DispatchWorkItemSubscription.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import OSLogger
import Foundation

class DispatchWorkItemSubscription: APISubscriptionProtocol {
    private let item: DispatchWorkItem
    
    deinit {
        if (!self.item.isCancelled) {
            self.item.cancel()
        }
    }
    
    init(item: DispatchWorkItem) {
        self.item = item
    }
    
    func dispose() {
        OSLogger.networkLog(message: "disposing \(self)", access: .public, type: .debug)
        self.item.cancel()
    }
    
    var isDisposed: Bool {
        get {
            return self.item.isCancelled
        }
    }
}
