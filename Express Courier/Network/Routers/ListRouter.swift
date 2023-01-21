//
//  ListRouter.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import Alamofire

enum ListRouter: BaseURLRequestConvertible {
    
    case getAllPackages(model: getAllPackagesRequest)
    case listPackages(model: ListPackagesRequest)
    case statsPackages(model: StatsPackagesRequest)
    case countPackages(model: CountPackagesRequest)
    
    var path: String {
        switch self {
        case .getAllPackages(let model):
            return "/api/driver/package-lists?page=\(model.page)"
        case .listPackages(let model):
            return "/api/driver/package-lists/\(model.id)/packages?page=\(model.page)&status=\(model.status)"
        case .statsPackages(let model):
            return "/api/driver/package-lists/\(model.id)/stats"
        case .countPackages(let model):
            
            if let status = model.status {
                return "/api/driver/package-lists/\(model.id)/counter?status=\(status)&group_by=\(model.group_by)"
            }
            return "/api/driver/package-lists/\(model.id)/counter?group_by=\(model.group_by)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllPackages:
            return .get
        case .listPackages:
            return .get
        case .statsPackages:
            return .get
        case .countPackages:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case.getAllPackages:
            return nil
        case .listPackages:
            return nil
        case .statsPackages:
            return nil
        case .countPackages:
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
