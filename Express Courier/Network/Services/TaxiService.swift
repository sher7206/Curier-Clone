//
//  TaxiService.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//

import Foundation

struct TaxiService: BaseService {
    
    typealias Convertible = TaxiRouter
    
    func getNewsTaxi(model: TaxiRequest, completion: @escaping Completion<GetNewsTaxiResponse>) {
        request(.getNewTaxi(model: model), completion: completion)
    }
    
    func getHistoryTaxi(model: TaxiRequest, completion: @escaping Completion<GetHistoryTaxiResponse>) {
        request(.getNewTaxi(model: model), completion: completion)
    }
}
