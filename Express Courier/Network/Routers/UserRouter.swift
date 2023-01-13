//
//  GetmeRouter.swift
//  100kExpress
//
//  Created by Sherzod on 09/12/22.
//

import Alamofire

enum UserRouter: BaseURLRequestConvertible {
    
    case getMe
    case updateProfile
    case logout
   
    case deleteAccount
    
    var path: String {
        switch self {
        case.getMe:
            return "/api/profile"
        case.updateProfile:
            return "/api/profile/update"
        case.logout:
            return "/api/profile/logout"
        case .deleteAccount:
            return "api/profile"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getMe:
            return .get
        case.updateProfile:
            return .post
        case.logout:
            return .post
        case .deleteAccount:
            return .delete
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
