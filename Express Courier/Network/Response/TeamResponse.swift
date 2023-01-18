//
//  TeamResponse.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

import UIKit

struct AddTeamResponse: Codable {
    
    var message: String?
    var data: AddTeamData?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(AddTeamData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case message, data
    }
    
}

struct AddTeamData: Codable {
    var id: Int?
    var name: String?
    var surname: String?
    var email: String?
    var created_at: String?
    var created_at_label: String?
}
