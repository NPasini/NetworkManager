//
//  NetworkProtocols.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

protocol APISubscriptionProtocol {
    var isDisposed: Bool { get }
    func dispose()
}
