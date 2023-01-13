//
//  NetworkFlowDelegate.swift
//  DermopicoHair
//
//  Created by Bilal Bakhrom on 14/04/2022.
//  Copyright © 2022 Chowis Co, Ltd. All rights reserved.
//

protocol NetworkFlowDelegate: AnyObject {
    func networkFlowDidStartRequest()
    func networkFlowDidFinish()
    func networkFlowDidHandleError(_ message: String?)
}
