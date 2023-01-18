//
//  TeamRequest.swift
//  Express Courier
//
//  Created by Sherzod on 18/01/23.
//

import UIKit

struct AddTeamRequest: Codable {
    var username: String
    var name: String
    var region_id: Int
    var district_id: Int
}
