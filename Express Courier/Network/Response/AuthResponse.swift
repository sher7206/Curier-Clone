//
//  LoginResponse.swift
//  Nation
//
//  Created by Sherzod on 04/12/22.
//

struct LoginResponse: Codable {
    
    var message: String?
    var data: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(String.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case message, data
    }
    
}

struct RegisterResponse: Codable {
    var message: String?
    var data: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(String.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case message, data
    }
}

struct FcmTokenResponse: Codable{
    var message: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
