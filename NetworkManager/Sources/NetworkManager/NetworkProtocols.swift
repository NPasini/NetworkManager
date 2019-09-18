//
//  NetworkProtocols.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

protocol APISubscriptionProtocol {
    var isDisposed: Bool { get }
    func dispose()
}
