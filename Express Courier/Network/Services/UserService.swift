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
    
    func getTransactions(model: GetTransactionsRequest, completion: @escaping Completion<GetTransactionsResponse>) {
        request(.getTransactions(model: model), completion: completion)
    }
    
    func getNotifications(model: GetNotificationsRequest, completion: @escaping Completion<GetNotificationsResponse>) {
        request(.getNotifications(model: model), completion: completion)
    }
}
