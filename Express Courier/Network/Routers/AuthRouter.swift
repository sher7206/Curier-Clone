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
    case resetPassword(model: ResetPasswordRequest)
    case verifyCode(model: VerifyCodeRequest)
    case confirmPassword(model: ConfirmPasswordRequest)
    case sendFcmToken(model: FcmTokenRequest)

    
    var path: String {
        switch self {
        case.register:
            return "/api/auth/sanctum/register"
        case .login:
            return "/api/auth/sanctum/login"
        case .resetPassword:
            return "/api/auth/sanctum/reset-password"
        case .verifyCode:
            return "/api/auth/sanctum/verify-code"
        case .confirmPassword:
            return "/api/profile/update-password"
        case .sendFcmToken:
            return "/api/profile/set-device-token"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.register:
            return .post
        case .login:
            return .post
        case .resetPassword:
            return .post
        case .verifyCode:
            return .post
        case .confirmPassword:
            return .post
        case .sendFcmToken:
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
        case .resetPassword(let model):
            let params: [String: Any] = [
                "username": model.username
            ]
            return params
        case .verifyCode(let model):
            let params: [String: Any] = [
                "username": model.username,
                "code": model.code
            ]
            return params
        case .confirmPassword(let model):
            let params: [String: Any] = [
                "password": model.password,
                "password_confirmation": model.password_confirmation
            ]
            return params
        case .sendFcmToken(let model):
            let param: [String: Any] = ["fcm_token" : model.fcm_token,
                                        "platform" : model.platform,
                                        "app_id" : model.app_id]
            return param
            
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
