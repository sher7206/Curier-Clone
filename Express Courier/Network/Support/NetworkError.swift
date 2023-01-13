//
//  NetworkError.swift
//  DermopicoHair
//
//  Created by Bilol Mamadjanov on 26/12/21.
//  Copyright © 2021 Chowis Co, Ltd. All rights reserved.
//

public enum NetworkError: Swift.Error {
    /// The error send by backend
    case standard(title: String, description: String)
    /// Error handled in iOS app
    case technical(title: String, description: String)
    /// Unhandled error
    case unexpected(description: String)
    /// No network connection
    case unableToConnect
    
    public var localizedDescription: String {
        switch self {
        case .standard(let title, let description):
            return "\(title):: \(description)"
            
        case .unexpected(let description):
            return description
            
        case let .technical(title, description):
            return "\(title)\n\(description)"
            
        case .unableToConnect:
            return "Unable to connect to network\nCheck if you have Wi-Fi or mobile Internet enabled, and try again"
        }
    }
    
    public var message: String? {
        switch self {
        case .standard(_, let description):
            return description
        case .technical(_, let description):
            return description
        case .unexpected(let description):
            return description
        case .unableToConnect:
            return "Unable to connect to network\nCheck if you have Wi-Fi or mobile Internet enabled, and try again"
        }
    }
}
