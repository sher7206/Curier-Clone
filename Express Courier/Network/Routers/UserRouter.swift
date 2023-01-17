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
    case getRegion
    case updateUser
    case getNews(model: GetNewsRequest)
    case logOut
    
    var path: String {
        switch self {
        case .getMe:
            return "/api/profile"
        case .getTransactions(let model):
            return "/api/profile/transactions?page=\(model.page)"
        case .getNotifications(let model):
            return "/api/profile/notifications?page=\(model.page)"
        case .getRegion:
            return "/api/locations"
        case .updateUser:
            return "/api/profile/update"
        case .getNews(let model):
            return "/api/news?page=\(model.page)"
        case .logOut:
            return "/api/profile/logout"
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
        case .getRegion:
            return .get
        case .updateUser:
            return .post
        case .getNews:
            return .get
        case .logOut:
            return .post
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
