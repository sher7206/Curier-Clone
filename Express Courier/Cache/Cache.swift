//
//  Cache.swift
//  Clickjobs New
//
//  Created by Sherzod on 27/03/2022.
//


struct UserDM: Codable {
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
    var created_at: String?
    var created_at_label: String?
}

import Foundation

class Cache {
    static let share: Cache = Cache()
    
    func getUserToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.userToken)
    }
    
    //Get User
    static func getUser()-> UserDM? {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: Keys.userInfo) as? Data {
            if let decodeData = try? decoder.decode(UserDM.self, from: data){
                return decodeData
            }
        }
        return nil
    }
    
    //Save User
    static func saveUser(user : UserDM?) {
        let encode = JSONEncoder()
        if let data = try? encode.encode(user){
            UserDefaults.standard.setValue(data, forKey: Keys.userInfo)
        }
    }
}
