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
    
    var data: [GetTransactionsData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetTransactionsData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct GetTransactionsData: Codable {
    var id: Int?
    var read_at: String?
    var title: String?
    var description: String?
    var image: String?
    var created_at: String?
    var created_at_label: String?
}

struct Link: Codable {
    var first: String?
    var last: String?
    var prev: String?
    var next: String?
}

struct Meta: Codable {
    var current_page: Int?
    var from: Int?
    var last_page: Int?
    var links: [Links]?
    var path: String?
    var per_page: Int?
    var to: Int?
    var total: Int?
}

struct Links: Codable {
    var url: String?
    var label: String?
    var active: Bool?
}
