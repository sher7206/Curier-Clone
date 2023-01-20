//
//  BranchService.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

struct BranchService: BaseService {
    typealias Convertible = BranchRouter
    
    func getBranches(model: GetBranchRequest, completion: @escaping Completion<GetBranchResponse>) {
        request(.getBranches(model: model), completion: completion)
    }
}
