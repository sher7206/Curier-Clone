//
//  TaxiRequest.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//

struct TaxiRequest: Codable {
    var page: Int
    var fromRegionId: Int?
    var fromDistrictId: Int?
    var toRegionId: Int?
    var toDistrictId: Int?
}

struct TaxiPostRequest: Codable {
    var id: Int
}
