//
//  AuthRouter.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import Alamofire

enum AuthRouter: BaseURLRequestConvertible {
    
    case register(model: RegisterRequest)
    case login(model: LoginRequest)
    
    var path: String {
        switch self {
        case.register:
            return "/api/auth/sanctum/register"
        case .login:
            return "/api/auth/sanctum/login"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.register:
            return .post
        case .login:
            return .post
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case.register(let model):
            let params: [String: Any] = [
                "phone": model.phone,
                "password": model.password,
                "name": model.name
            ]
            return params
        case .login(model: let model):
            let params: [String: Any] = [
                "username": model.username,
                "password": model.password
            ]
            return params
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
