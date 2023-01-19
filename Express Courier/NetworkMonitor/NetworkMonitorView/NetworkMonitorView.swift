//
//  NetworkMonitorView.swift
//  Paywork
//
//  Created by Asliddin Rasulov on 28/06/22.
//

import UIKit

class NetworkMonitorView: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel?.text = "It looks like you`re not connected to the internet"
//        messageLabel?.font = UIFont.SFProDisplay(.medium, size: 18)
    }
}
