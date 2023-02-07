//
//  UserRequest.swift
//  Express Courier
//
//  Created by Sherzod on 13/01/23.
//

struct GetTransactionsRequest {
    var page: Int
}

struct GetNotificationsRequest {
    var page: Int
}

struct GetNewsRequest {
    var page: Int
}

struct BecomeCourierRequest {
    var passport: String
    var transport_type: String
    var drivers_license: String
}

struct NewRequest{
    var id: Int
}

struct RefreshTokenRequest {
    var token: String
}
