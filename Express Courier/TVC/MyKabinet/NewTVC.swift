//
//  NewTVC.swift
//  100kExpress
//
//  Created by apple on 06/12/22.
//

import UIKit
import SDWebImage

class NewTVC: UITableViewCell {
    
    static let identifier = "NewTVC"
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var newImg: UIImageView!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var fullDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(date: String, imgV: String, title: String, desc: String) {
        self.dateLbl.text = String(date.prefix(10))
        self.newImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let url = imgV.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            newImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"), options: [.continueInBackground, .progressiveLoad])
            
        }
        self.newLbl.text = title
        self.fullDescLbl.text = desc
    }
}
