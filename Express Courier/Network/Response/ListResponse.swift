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
    var is_closed: Bool?
    var store_avatar: String?
    var store_phone: String?
    var store_id: Int?
    var store_name: String?
    var packages_amount:Int?
    var packages_count:Int?
    var packages_count_sold:Int?
    var created_at: String?
    var created_at_label: String?
}
