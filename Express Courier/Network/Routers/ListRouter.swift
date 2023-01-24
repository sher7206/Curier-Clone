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
    case listDistrict(model: ListDistrictResquest)
    case lisdDistrictDates(model: ListDistrictDatesRequest)
    
    var path: String {
        switch self {
        case .getAllPackages(let model):
            return "/api/driver/package-lists?page=\(model.page)"
        case .listPackages(let model):
            
            if let toDistrictId = model.toDistrictId {
                return "/api/driver/package-lists/\(model.id)/packages?page=\(model.page)&status=\(model.status)&toDistrictId=\(toDistrictId)"
            }
            
            return "/api/driver/package-lists/\(model.id)/packages?page=\(model.page)&status=\(model.status)"
        case .statsPackages(let model):
            return "/api/driver/package-lists/\(model.id)/stats"
        case .countPackages(let model):
            
            if let status = model.status {
                return "/api/driver/package-lists/\(model.id)/counter?status=\(status)&group_by=\(model.group_by)"
            }
            return "/api/driver/package-lists/\(model.id)/counter?group_by=\(model.group_by)"
        case .listDistrict(let model):
            return "/api/driver/package-lists/\(model.id)/districts"
        case .lisdDistrictDates(let model):
            return "/api/driver/package-lists/\(model.id)/packages?page=\(model.page)&status=\(model.status)&toDistrictId=\(model.toDistrictId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
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
