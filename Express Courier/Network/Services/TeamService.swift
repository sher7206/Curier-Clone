//
//  TeamService.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

struct TeamService: BaseService {
    
    typealias Convertible = TeamRouter
    
    func addTeam(model: AddTeamRequest, completion: @escaping Completion<AddTeamResponse>) {
        request(.addTeam(model: model), completion: completion)
    }
}
