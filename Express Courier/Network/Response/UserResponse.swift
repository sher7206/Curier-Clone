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
    var type: String?
    var amount: Int?
    var comment: String?
    var created_at: String?
    var created_at_label: String?
}


//MARK: - GetNotificationsResponse
struct GetNotificationsResponse: Codable {
    
    var data: [GetNotificationsData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetNotificationsData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}

struct GetNotificationsData: Codable {
    
    var id: String?
    var read_at: String?
    var title: String?
    var description: String?
    var image: String?
    var data: DataNotification?
    var created_at: String?
    var created_at_label: String?
}

struct DataNotification: Codable {
    var title: String?
    var description: String?
}


//MARK: - Get Regions
struct GetRegionResponse: Codable {
    
    var data: [GetRegionDM]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetRegionDM].self, forKey: .data)
        
    }
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}

struct GetRegionDM: Codable {
    var id: Int?
    var name: String?
    var districts: [DistrictsDM]?
}

struct DistrictsDM: Codable {
    var id: Int?
    var name: String?
    var region_id: Int?
}

//MARK: - UpdateUserResponse
struct UpdateUserResponse: Codable {
    var data: GetMeData?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(GetMeData.self, forKey: .data)
        
    }
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}

//MARK: - GetNewsResponse
struct GetNewsResponse: Codable {
    var data: [GetNewsData]?
    var links: Link?
    var meta: Meta?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([GetNewsData].self, forKey: .data)
        links = try? container.decode(Link.self, forKey: .links)
        meta = try? container.decode(Meta.self, forKey: .meta)
        
    }
    enum CodingKeys: String, CodingKey {
        case data, links, meta
    }
}


struct GetOneNewResponse: Codable{
    var data: GetNewsData?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(GetNewsData.self, forKey: .data)
    }
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct GetNewsData: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var created_at: String?
    var is_active: Bool?
    var image: String?
    var created_at_label: String?
}

//MARK: - Log Out
struct LogOutResponse: Codable {
    var message: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    enum CodingKeys: String, CodingKey {
        case message
    }
}


//MARK: - Become Courier Response
struct BecomeCourierResponse: Codable {
    var message: String?
    var data: BecomeCourierData?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(BecomeCourierData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case message, data
    }
}

struct BecomeCourierData: Codable {
    var id: Int?
    var user_id: Int?
    var name: String?
    var phone: String?
    var surname: String?
    var comment: String?
    var status: String?
    var transport_type: String?
    var created_at: String?
    var passport: String?
    var drivers_license: String?
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
