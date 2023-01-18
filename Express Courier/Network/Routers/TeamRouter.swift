//
//  TeamRouter.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

import Alamofire

enum TeamRouter: BaseURLRequestConvertible {
    
    case addTeam(model: AddTeamRequest)
    
    var path: String {
        switch self {
        case .addTeam:
            return "/api/profile/team"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.addTeam:
            return .post
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .addTeam(let model):
            let params: [String: Any] = [
                "username": model.username,
                "name": model.name,
                "region_id": model.region_id,
                "district_id": model.district_id
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
