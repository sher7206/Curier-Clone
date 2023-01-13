
//  Header.swift
//  DermopicoHair
//  Created by Bilol Mamadjanov on 26/12/21.
//  Copyright © 2021 Chowis Co, Ltd. All rights reserved.

import Foundation

struct Header {
    enum Key {
        /// Content-Type
        case contentType
        /// Accept
        case accept
        /// Authorization
        case authorization
        /// access_token
        case accessToken
        /// Language
        case language
        case macAddress
        case custom(key: String)
        var key: String {
            switch self {
            case .contentType:
                return "Content-Type"
            case .accept:
                return "Accept"
            case .authorization:
                return "Authorization"
            case .accessToken:
                return "access_token"
            case .language:
                return "Language"
            case .macAddress:
                return "mac_address"
            case .custom(let key):
                return key
            }
        }
    }
}

extension Header {
    enum Value {
        case applicationJSON
        case applicationFormURLEncoded
        case multipartFormData
        case language(code: String)
        case custom(value: String)
        case SmsToken
        case token
        var value: String {
            switch self {
            case .applicationJSON:
                return "application/json"
            case .applicationFormURLEncoded:
                return "multipart/form-data; boundary=Boundary-\(UUID().uuidString)"
            case .multipartFormData:
                return "multipart/form-data"
            case .language(let code):
                return code
            case .custom(let value):
                return value
            case .SmsToken:
                return ""
            case .token:
                return "Bearer " + "101|LcXexMEolw0EVzX6XYHj5ZHRXXTh2zpGq2NCuRtc"
            }
        }
    }
}


extension Header.Key: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .custom(let key):
            hasher.combine(key)
        case .authorization:
            hasher.combine(key)
        default:
            break
        }
    }
}

