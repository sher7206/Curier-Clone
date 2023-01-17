//
//  TaxiRouter.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//

import Alamofire

enum TaxiRouter: BaseURLRequestConvertible {
    
    case getNewTaxi(model: TaxiRequest)
    case getHistoryTaxi(model : TaxiRequest)
    case posTaxi(model: TaxiPostRequest)
    
    var path: String {
        switch self {
        case.getNewTaxi(let model):
            
            if let fromRegionId = model.fromRegionId, let fromDistrictId = model.fromDistrictId, let toRegionId = model.toRegionId, let toDistrictId = model.toDistrictId {
                
                return "/api/driver/caborders?page=1&fromRegionId=1&fromDistrictId=1&toRegionId=1&toDistrictId=1"
            }
            return "/api/driver/caborders?page=\(model.page)"
        case .getHistoryTaxi(let model):
            return "/api/driver/caborders/history?page=\(model.page)"
        case .posTaxi(let model):
            return "/api/driver/caborders/\(model.id)/accept"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getNewTaxi:
            return .get
        case .getHistoryTaxi:
            return .get
        case .posTaxi:
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
