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

//MARK: - Reset Password Response
struct ResetPasswordResponse: Codable {
    
    var message: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct VerifyCodeResponse: Codable {
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

struct ConfirmPasswordResponse: Codable {
    
    var data: ConfirmPasswordData?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(ConfirmPasswordData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct ConfirmPasswordData: Codable {
    var id: Int?
    var name: String?
    var surname: String?
    var email: String?
    var created_at: String?
    var created_at_label: String?
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


