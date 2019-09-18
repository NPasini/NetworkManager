//
//  ResponseProtocols.swift
//  spay
//
//  Created by Pasini, Nicolò on 18/08/2019.
//  Copyright © 2019 Pasini, Nicolò. All rights reserved.
//

import Foundation

protocol CustomDecodable: Decodable {
    static func decode(_ data: Data) -> CustomDecodable?
}
