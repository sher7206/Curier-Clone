//
//  AboutNewVC.swift
//  100kExpress
//
//  Created by apple on 06/12/22.
//

import UIKit
import SDWebImage

class AboutNewVC: UIViewController {
    
    var dates: GetNewsData?
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        uploadDates()
    }
    
    func uploadDates() {
        //        self.imgV.sd_setImage(with: URL(string: dates?.image ?? ""))
        guard let imgStr = dates?.image else {return}
        
        if let url = imgStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            imgV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"), options: [.continueInBackground, .progressiveLoad])
            
            self.titleLbl.text = dates?.title ?? ""
            self.descLbl.text = dates?.description ?? ""
        }
    }
}
