//
//  BranchRouter.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

import Alamofire

enum BranchRouter: BaseURLRequestConvertible {
    
    case getBranches(model: GetBranchRequest)
    
    var path: String {
        switch self {
        case.getBranches(let model):
            return "/api/storages?page=\(model.page)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getBranches:
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
