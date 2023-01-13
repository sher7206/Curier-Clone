//
//  UserService.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

import Alamofire

struct UserService: BaseService {
    
    typealias Convertible = UserRouter
    
    func getMe(completion: @escaping Completion<GetMeResponse>) {
        request(.getMe, completion: completion)
    }
}
