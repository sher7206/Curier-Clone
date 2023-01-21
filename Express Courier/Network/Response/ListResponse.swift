//
//  ListResponse.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import UIKit

//MARK: - Get All PackagesRequest
struct getAllPackagesResponse: Codable {
    
    var data: [GetAllPackagesData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetAllPackagesData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct GetAllPackagesData: Codable {
    var id: Int?
    var created_at: String?
    var created_at_label: String?
    var is_closed: Bool?
    var storage_id: Int?
    var storage_logo: String?
    var storage_phone: String?
    var storage_name: String?
    var packages_count: Int?
    var packages_amount: String?
    var packages_count_sold: Int?
}

//MARK: - List Packages Response
struct ListPackagesResponse: Codable {
    var data: [ListPackagesData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([ListPackagesData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct ListPackagesData: Codable {
    var id: Int?
    var creator_id: Int?
    var creator_name: String?
    var creator_phone: String?
    var creator_avatar: String?
    var driver_id: Int?
    var driver_name: String?
    var driver_phone: String?
    var recipient_name: String?
    var recipient_phone: String?
    var from_region_id: Int?
    var from_region_name: String?
    var from_district_id: Int?
    var from_district_name: String?
    var from_address: String?
    var to_region_id: Int?
    var to_region_name: String?
    var to_district_id: Int?
    var to_district_name: String?
    var to_address: String?
    var note: String?
    var status: String?
    var matter: String?
    var vehicle_type: String?
    var is_paid: Int?
    var status_label: String?
    var cash_amount: Int?
    var delivery_fee_amount: Int?
    var insurance_amount: Int?
    var expired_at: String?
    var created_at: String?
    var created_at_label: String?
}
