//
//  AuthRouter.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import Alamofire

enum AuthRouter: BaseURLRequestConvertible {
    
    var path: String
    
    var method: Alamofire.HTTPMethod
    
    var parameters: Alamofire.Parameters?
    
    func asURLRequest() throws -> URLRequest {
        
    }
    
    
}
