

//  PostRouter.swift
//  Express Courier
//  Created by apple on 17/01/23.

import Foundation
import Alamofire

enum PostRouter: BaseURLRequestConvertible {
    
    case getPost(model: PostRequest)
    
    var path: String {
        switch self {
        case.getPost(let model):
            if let fromRegionId = model.fromRegionId, let fromDistrictId = model.fromDistrictId, let toRegionId = model.toRegionId, let toDistrictId = model.toDistrictId {
                return "/api/driver/packages/\(model.available)\(model.status)?page=\(model.page)&fromRegionId=\(fromRegionId)&fromDistrictId=\(fromDistrictId)&toRegionId=\(toRegionId)&toDistrictId=\(toDistrictId)"
            }
            if let fromRegionId = model.fromRegionId, let fromDistrict = model.fromDistrictId {
                return "/api/driver/packages/\(model.available)\(model.status)?page=\(model.page)&fromRegionId=\(fromRegionId)&fromDistrictId=\(fromDistrict)"
            }
            if let toRegionId = model.toRegionId, let toDistrict = model.toDistrictId {
                return "/api/driver/packages/\(model.available)\(model.status)\(model.status)?page=\(model.page)&toRegionId=\(toRegionId)&toDistrictId=\(toDistrict)"
            }
            if let fromRegionId = model.fromRegionId {
                return "/api/driver/packages/\(model.available)\(model.status)?page=\(model.page)&fromRegionId=\(fromRegionId)"
            }
            if let toRegionId = model.toRegionId {
                return "/api/driver/packages/\(model.available)\(model.status)?page=\(model.page)&toRegionId=\(toRegionId)"
            }
            return "/api/driver/packages/\(model.available)\(model.status)?page=\(model.page)"
        }
    }
    
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getPost:
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
