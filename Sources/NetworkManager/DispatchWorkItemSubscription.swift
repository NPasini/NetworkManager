//
//  DispatchWorkItemSubscription.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Logger
import Foundation

internal class DispatchWorkItemSubscription: APISubscriptionProtocol {
    private let item: DispatchWorkItem
    
    deinit {
        if (!self.item.isCancelled) {
            self.item.cancel()
        }
    }
    
    internal init(item: DispatchWorkItem) {
        self.item = item
    }
    
    internal func dispose() {
        NetworkLogger.debugLog(message: "disposing \(self)", access: .public)
        self.item.cancel()
    }
    
    internal var isDisposed: Bool {
        get {
            return self.item.isCancelled
        }
    }
}
