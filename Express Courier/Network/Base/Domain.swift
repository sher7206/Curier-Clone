
//  Domain.swift
//  DermopicoHair
//  Created by Bilol Mamadjanov on 26/12/21.

enum Domain {
    case base
    var string: String {
        switch self {
        case .base:
            return "https://yuzka.uz"
        }
    }
}
