//
//  ListRouter.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import Alamofire

enum ListRouter: BaseURLRequestConvertible {
    
    case getAllPackages(model: getAllPackagesRequest)
    
    var path: String {
        switch self {
        case .getAllPackages(let model):
            return "/api/driver/package-lists?page=\(model.page)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllPackages:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case.getAllPackages:
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
