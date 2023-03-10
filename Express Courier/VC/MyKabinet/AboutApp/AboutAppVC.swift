//
//  AboutAppVC.swift
//  Express Courier
//`
//  Created by Sherzod on 16/01/23.
//

import UIKit
import WebKit

class AboutAppVC: UIViewController {
    
    /// Outlets
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    func setupData() {
        navigationItem.title = "100k.uz"
        guard let url = URL (string: "https://yuzka.uz/") else {return}
        let requestObj = URLRequest(url: url)
        DispatchQueue.main.async {
            self.webView.load(requestObj)
        }
    }
}
