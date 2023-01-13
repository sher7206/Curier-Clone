//
//  NetworkExtension.swift
//  DermopicoHair
//
//  Created by Bilol Mamadjanov on 26/12/21.
//  Copyright © 2021 Chowis Co, Ltd. All rights reserved.
//

import Foundation

extension URLRequest {
    /**
     Sets value to header field
     
     - Parameter key: Header key
     - Parameter value: Header value
     */
    mutating func add(key: Header.Key, value: Header.Value) {
        setValue(value.value, forHTTPHeaderField: key.key)
    }
    
    mutating func add(contentOf headers: [Header.Key: Header.Value]) {
        headers.forEach { add(key: $0.key, value: $0.value) }
    }
}
