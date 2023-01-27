//
//  MyInfoTVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit
import SDWebImage

class MyInfoTVC: UITableViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personPhoneNumber: UILabel!
    @IBOutlet weak var personId: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var shotLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(data: UserDM?) {
        self.personImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.personImage.sd_setImage(with: URL(string: data?.avatar ?? "")) { img, _, _, _ in
            if let _ = img {
            } else {
                self.personImage.image = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
        }
        personName.text = (data?.name ?? "") + " " + (data?.surname ?? "")
        personPhoneNumber.text = data?.phone ?? ""
        personId.text = "#" + "\(data?.id ?? 0)"
        levelLbl.text = "+\(data?.rating ?? 0)"
        walletLbl.text = "\(data?.balance ?? 0) uzs"
        shotLbl.text = "\(data?.balance ?? 0) uzs"
    }
    
    
}
