//
//  DispatchWorkItemSubscription.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

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
//        OSLogger.networkLog(message: "disposing \(self)", access: .public, type: .debug)
        self.item.cancel()
    }
    
    var isDisposed: Bool {
        get {
            return self.item.isCancelled
        }
    }
}
