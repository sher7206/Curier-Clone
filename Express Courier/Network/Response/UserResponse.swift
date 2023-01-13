//
//  UserResponse.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//


//MARK: - GetMeResponse
struct GetMeResponse: Codable {
    
    var data: GetMeData?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(GetMeData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct GetMeData: Codable {
    var id: Int?
    var name: String?
    var surname: String?
    var email: String?
    var phone: String?
    var balance: Int?
    var rating: Int?
    var region_id: Int?
    var region_name: String?
    var district_id: Int?
    var district_name: String?
    var detail_address: String?
    var avatar: String?
    var roles: [String]?
    var created_at: String?
    var created_at_label: String?
}


//MARK: - GetTransactionsResponse
struct GetTransactionsResponse: Codable {
    
    var data: [String]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        data = try? container.decode(GetMeData.self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct Link: Codable {
    var first: String?
    var last: String?
    var prev: String?
    var next: String?
}

struct Meta: Codable {
    var current_page: Int?
    var from: String?
    var last_page: Int?
    var links: [Links]
}

struct Links: Codable {
    var url: String?
    var label: String?
    var active: Bool?
}
