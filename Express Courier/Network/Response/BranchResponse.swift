//
//  BranchResponse.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

import UIKit

struct GetBranchResponse: Codable {
    var data: [BranchData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([BranchData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct BranchData: Codable {
    var id: Int?
    var owner_user_id: Int?
    var name: String?
    var region_id: Int?
    var district_id: Int?
    var call_center: String?
    var updated_at: String?
    var created_at: String?
    var region: BranchRegionData?
    var district: BranchdDistrictData?
    var logo: String?
    var service_fee_percent: Int?
    var is_can_accept_parcels: Int?
    var created_at_label: String?
}

struct BranchRegionData: Codable {
    var id: Int?
    var name: String?
    var delivery_amount: Int?
    var delivery_timer_in_hours: Int?
}

struct BranchdDistrictData: Codable {
    var id: Int?
    var region_id: Int?
    var name: String?
    var delivery_amount: Int?
    var delivery_timer_in_hours: Int?
}
