//
//  LoginRequest.swift
//  Nation
//
//  Created by Sherzod on 04/12/22.
//

struct LoginRequest {
    var username: String
    var password: String
}

struct RegisterRequest {
    var name: String
    var phone: String
    var password: String
}

struct FcmTokenRequest{
    var fcm_token: String
    var platform: String
    var app_id: String
}

