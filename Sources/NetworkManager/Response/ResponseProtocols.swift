//
//  ResponseProtocols.swift
//
//
//  Created by Pasini, Nicolò on 18/09/2019.
//

import Foundation

public protocol CustomDecodable: Decodable {
    static func decode(_ data: Data) -> CustomDecodable?
}
