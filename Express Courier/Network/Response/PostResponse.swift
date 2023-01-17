//
//  PostResponse.swift
//  Express Courier
//
//  Created by apple on 17/01/23.
//

import Foundation


//MARK: - GetNewsTaxiResponse
struct GetPostResponse: Codable {
    var data: [GetPostRespnseData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetPostRespnseData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CondingKeys : String, CodingKey {
        case data, links, meta
    }
    
}

struct GetPostRespnseData: Codable {
    var id: Int?
    var creator_id: Int?
    var creator_name: String?
    var creator_avatar: String?
    var driver_id: Int?
    var driver_name: String?
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
    var cash_amount: Double?
    var delivery_fee_amount: Double?
    var insurance_amount: Double?
    var expired_at: String?
    var created_at: String?
    var created_at_label: String?
}
