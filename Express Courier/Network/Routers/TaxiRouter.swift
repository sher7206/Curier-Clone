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
    
    var path: String {
        switch self {
        case.getNewTaxi(let model):
            return "/api/driver/caborders?page=\(model.page)"
        case .getHistoryTaxi(let model):
            return "/api/driver/caborders/history?page=\(model.page)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getNewTaxi:
            return .get
        case .getHistoryTaxi:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case.getNewTaxi:
            return nil
        case .getHistoryTaxi:
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
