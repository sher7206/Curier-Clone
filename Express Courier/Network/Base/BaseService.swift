//  BaseService.swift
//  DermopicoHair
//  Created by Bilol Mamadjanov on 26/12/21.
//  Copyright © 2021 Chowis Co, Ltd. All rights reserved.

import Alamofire

protocol BaseService {
    associatedtype Convertible: URLRequestConvertible
    typealias Completion<T> = (Result<T, NetworkError>) -> Void
    
    func request<T: Codable>(_ convertible: Convertible, completion: @escaping Completion<T>)
}

extension BaseService {
    
    func request<T: Codable>(_ convertible: Convertible,  completion: @escaping Completion<T>) {
        // Create a reqeust.
        let request = AF.request(convertible)
//        if mode == .other {
//            Utils.shared.showLoading()
//        }
        // Send request and handle response.
        request.responseDecodable(queue: .global(qos: .background)) { response in
            // Monitor response.
            AnalysisResponseMonitor<T>(response: response).monitor(completion: completion)
        }
    }
}

