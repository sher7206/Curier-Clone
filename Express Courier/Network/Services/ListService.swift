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
    
    func listPackages(model: ListPackagesRequest, completion: @escaping Completion<ListPackagesResponse>) {
        request(.listPackages(model: model), completion: completion)
    }
    
    func statsPackages(model: StatsPackagesRequest, completion: @escaping Completion<StatsPackagesResponse>) {
        request(.statsPackages(model: model), completion: completion)
    }
    
    func countPackages(model: CountPackagesRequest, completion: @escaping Completion<CountPackagesResponse>) {
        request(.countPackages(model: model), completion: completion)
    }
    
    func listDistrict(model: ListDistrictResquest, completion: @escaping Completion<ListDistrictRessponse>) {
        request(.listDistrict(model: model), completion: completion)
    }
    
    func listDistrictDates(model: ListDistrictDatesRequest, completion: @escaping Completion<ListDistrictDatesResponse>) {
        request(.lisdDistrictDates(model: model), completion: completion)
    }
}
