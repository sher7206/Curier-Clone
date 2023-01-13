//
//  UserRouter.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import Alamofire

enum UserRouter: BaseURLRequestConvertible {
    
    case getMe
    
    var path: String {
        switch self {
        case .getMe:
            return "/api/profile"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getMe:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getMe:
            return nil
        }
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
