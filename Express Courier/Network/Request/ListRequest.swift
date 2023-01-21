//
//  ListRequest.swift
//  Express Courier
//
//  Created by Sherzod on 20/01/23.
//

import UIKit

struct getAllPackagesRequest {
    var page: Int
}

struct ListPackagesRequest {
    var id: Int
    var page: Int
    var status: String
}
