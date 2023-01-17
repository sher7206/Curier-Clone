

//  PostRouter.swift
//  Express Courier
//  Created by apple on 17/01/23.

import Foundation
import Alamofire

enum PostRouter: BaseURLRequestConvertible {
    
    case getPost(model: PostRequest)
    
    var path: String {
        switch self {
        case.getPost(let model):
            return "/api/driver/packages/available?page=\(model.page)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getPost:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = makeURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.add(contentOf: .defaultHeaders)
        if let parameters = parameters {
            urlRequest = try JSONEncoding().encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
