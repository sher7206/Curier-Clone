//
//  NotificationTVC.swift
//  Express Courier
//
//  Created by Sherzod on 07/01/23.
//

import UIKit
import SDWebImage

class NotificationTVC: UITableViewCell {
    
    
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(data: GetNotificationsData) {
        guard let date = data.created_at else {return}
        if let url = data.image?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            imgV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"), options: [.continueInBackground, .progressiveLoad]) {img,_,_,_ in
                if let _ = img {
                    print("Rasm yuklandi!")
                } else {
                    self.imgV.image = UIImage(named: "notification-my")
                }
            }
        }
        self.textLbl.text = data.description ?? ""
        self.dateLbl.text = String(date.prefix(10))
    }
}
