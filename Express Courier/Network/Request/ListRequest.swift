//
//  ListRequest.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import UIKit

struct getAllPackagesRequest {
    var page: Int
}

struct ListPackagesRequest {
    var id: Int
    var page: Int
    var search: Int?
    var status: String
    var toDistrictId: Int?
}

struct StatsPackagesRequest {
    var id: Int
}

struct CountPackagesRequest {
    var id: Int
    var status: String?
    var group_by: String
}

struct ListDistrictResquest {
    var id: Int
}

struct ListDistrictDatesRequest: Codable {
    var id: Int
    var page: Int
    var status: String
    var toDistrictId: Int
}
