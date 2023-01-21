

//  PostRouter.swift
//  Express Courier
//  Created by apple on 17/01/23.

import Foundation
import Alamofire

enum PostRouter: BaseURLRequestConvertible {
    
    
    case getPost(model: PostRequest)
    case acceptPost(model: PostAcceptRequest)
    case getOnePost(model: PostIdRequest)
    case createChaPost(model: PostChatRequest)
    case getChatPost(model: PostGetChatRequest)
    case cancelPost(model: CancelOrderPostRequest)
    case confrimPost(model: ConfirmPostRequest)
    case takePost(model: TakeOrderPostRequest)
    case enterTimerPost(model: TimerOrderPostRequest)
    
    var path: String {
        switch self {
        case.getPost(let model):
            if let fromRegionId = model.fromRegionId, let fromDistrictId = model.fromDistrictId, let toRegionId = model.toRegionId, let toDistrictId = model.toDistrictId {
                return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)&fromRegionId=\(fromRegionId)&fromDistrictId=\(fromDistrictId)&toRegionId=\(toRegionId)&toDistrictId=\(toDistrictId)"
            }
            if let fromRegionId = model.fromRegionId, let fromDistrict = model.fromDistrictId {
                return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)&fromRegionId=\(fromRegionId)&fromDistrictId=\(fromDistrict)"
            }
            if let toRegionId = model.toRegionId, let toDistrict = model.toDistrictId {
                return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)\(model.status)&toRegionId=\(toRegionId)&toDistrictId=\(toDistrict)"
            }
            if let fromRegionId = model.fromRegionId {
                return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)&fromRegionId=\(fromRegionId)"
            }
            if let toRegionId = model.toRegionId {
                return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)&toRegionId=\(toRegionId)"
            }
            return "/api/driver/packages\(model.available)?page=\(model.page)\(model.status)"
        case .acceptPost(model: let model):
            return "/api/driver/packages/\(model.id)/accept"
        case .getOnePost(model: let model):
            return "/api/driver/packages/\(model.id)"
        case .createChaPost(model: let model):
            return "/api/driver/packages/\(model.id)/comments"
        case .getChatPost(model: let model):
            return "/api/driver/packages/\(model.id)/comments?page=\(model.page)"
        case .cancelPost(model: let model):
            return "/api/driver/packages/\(model.id)/cancel"
        case .confrimPost(model: let model):
            return "/api/driver/packages/\(model.id)/complete"
        case .takePost(model: let model):
            return "/api/driver/packages/\(model.id)/refresh-recipient"
        case .enterTimerPost(model: let model):
            return "/api/driver/packages/\(model.id)/delivery-time"

        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case.getPost:
            return .get
        case .acceptPost:
            return .post
        case .getOnePost:
            return .get
        case .createChaPost:
            return .post
        case .getChatPost:
            return .get
        case .cancelPost:
            return .patch
        case .confrimPost:
            return .patch
        case .takePost:
            return .patch
        case .enterTimerPost:
            return .patch
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getPost:
            return nil
        case .acceptPost:
            return nil
        case .getOnePost:
            return nil
        case .createChaPost(let model):
            let param: [String : Any] = ["text" : model.text]
            return param
        case .getChatPost:
            return nil
        case .cancelPost(model: let model):
            let param: [String : Any] = ["comment" : model.reason]
            return param
        case .confrimPost(model: let model):
            let param: [String : Any] = ["comment" : model.reason]
            return param
        case .takePost(model: let model):
            let param: [String : Any] = ["comment" : model.reason]
            return param
        case .enterTimerPost(model: let model):
            let param: [String : Any] = ["comment" : model.reason, "expired_at" : model.date]
            return param
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
