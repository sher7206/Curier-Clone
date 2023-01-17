//
//  TaxiResponse.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//

//MARK: - GetNewsTaxiResponse
struct GetNewsTaxiResponse: Codable {
    var data: [GetNewsTaxiData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetNewsTaxiData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CondingKeys : String, CodingKey {
        case data, links, meta
    }
}

struct GetNewsTaxiData: Codable {
    var id: Int?
    var creator_id: Int?
    var creator_name: String?
    var creator_phone: String?
    var creator_avatar: String?
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
    var book_front_seat: Bool?
    var seat_count: Int?
    var note: String?
    var cost: Int?
    var is_completed: Bool?
    var created_at: String?
    var created_at_label: String?
}

//MARK: - GetHistoryTaxiResponse
struct GetHistoryTaxiResponse: Codable {
    var data: [GetNewsTaxiData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetNewsTaxiData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CondingKeys : String, CodingKey {
        case data, links, meta
    }
}




