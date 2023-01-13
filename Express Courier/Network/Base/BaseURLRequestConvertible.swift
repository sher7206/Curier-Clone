//
//  BaseURLRequestConvertible.swift
//  DermopicoHair
//
//  Created by Bilol Mamadjanov on 26/12/21.
//  Copyright © 2021 Chowis Co, Ltd. All rights reserved.
//

import Alamofire

protocol BaseURLRequestConvertible: URLRequestConvertible {
    typealias Headers = [Header.Key: Header.Value]
    
    /// The endpoint of url request.
    var path: String { get}
    /// The HTTPMethod.
    var method: HTTPMethod { get }
    /// A dictionary of parameters to apply to a URLRequest.
    var parameters: Parameters? { get }
    /// The request headers
    var headers: Headers { get }
    /// Base domain
    var baseDomain: Domain { get }
}

extension BaseURLRequestConvertible {
    var baseDomain: Domain { .base }
    
    var headers: Headers { .defaultHeaders }
    
    func makeURL() -> URL {
        let path = path.hasPrefix("/") ? String(path.dropFirst()) : path
        let fullPath = "\(baseDomain.string)/\(path)"
        
        return URL(string: fullPath)!
    }
}

extension Dictionary where Key == Header.Key, Value == Header.Value {
    
    static var defaultHeaders: Self {
        [.accept: .applicationJSON,
         .contentType: .applicationJSON,
         .authorization: .token
        ]
    }
    
}
