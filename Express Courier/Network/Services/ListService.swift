//
//  ListService.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

struct ListService: BaseService {
    
    typealias Convertible = ListRouter
    
    func getAllPackages(model: getAllPackagesRequest, completion: @escaping Completion<getAllPackagesResponse>) {
        request(.getAllPackages(model: model), completion: completion)
    }
}
