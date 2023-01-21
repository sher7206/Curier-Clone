
//  BranchListTVC.swift
//  Express Courier
//  Created by apple on 14/01/23.

import UIKit
import SDWebImage

class BranchListTVC: UITableViewCell {
    
    static let identifier = "BranchListTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(data: GetAllPackagesData) {
        self.storeImg.sd_setImage(with: URL(string: data.store_avatar ?? "")) { img, _, _, _ in
            if let _ = img {
                print("Yuklandi!")
            } else { self.storeImg.image = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)}}
        self.storeNameLbl.text = data.store_name ?? ""
        self.productCountLbl.text = "\(data.packages_count ?? 0)"
        self.dateLbl.text = data.created_at ?? ""
        self.priceLbl.text = "\(data.packages_amount ?? 0) so'm"
    }
    
}
