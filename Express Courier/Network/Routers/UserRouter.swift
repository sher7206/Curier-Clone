//
//  UserRouter.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import Alamofire

enum UserRouter: BaseURLRequestConvertible {
    
    case getMe
    case getTransactions(model: GetTransactionsRequest)
    case getNotifications(model: GetNotificationsRequest)
    
    var path: String {
        switch self {
        case .getMe:
            return "/api/profile"
        case .getTransactions(let model):
            return "/api/profile/transactions?page=\(model.page)"
        case .getNotifications(let model):
            return "/api/profile/notifications?page=\(model.page)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getMe:
            return .get
        case .getTransactions:
            return .get
        case .getNotifications:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getMe:
            return nil
        case .getTransactions:
            return nil
        case .getNotifications:
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
