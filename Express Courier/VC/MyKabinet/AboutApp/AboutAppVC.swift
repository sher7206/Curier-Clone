//
//  AboutAppVC.swift
//  Express Courier
//
//  Created by Sherzod on 16/01/23.
//

import UIKit


class AboutAppVC: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://yuzka.uz/")
                let requestObj = URLRequest(url: url!)
                webView.loadRequest(requestObj)
    }
}
