
//  PostReques.swift
//  Express Courier
//  Created by apple on 17/01/23.

import Foundation
import UIKit


struct PostRequest: Codable {
    var page: Int
    var fromRegionId: Int?
    var fromDistrictId: Int?
    var toRegionId: Int?
    var toDistrictId: Int?
    var status: String
    var available: String
}

struct PostIdRequest: Codable {
    var id: Int
}

struct PostAcceptRequest{
    var id: Int
}

struct PostGetChatRequest{
    var page: Int
    var id: Int
}

struct PostChatRequest{
    var text: String
    var id: Int
}


struct CancelOrderPostRequest{
    var id: Int
    var reason: String
}


struct ConfirmPostRequest{
    var id: Int
    var reason: String
}

struct TakeOrderPostRequest{
    var id: Int
    var reason: String
}

struct TimerOrderPostRequest{
    var id: Int
    var reason: String
    var date: String
}

struct ReturnPostRequest{
    var id: Int
}
