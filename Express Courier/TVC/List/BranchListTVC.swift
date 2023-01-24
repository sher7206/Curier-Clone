
//  BranchListTVC.swift
//  Express Courier
//  Created by apple on 14/01/23.

import UIKit
import SDWebImage

class BranchListTVC: UITableViewCell {
    
    static let identifier = "BranchListTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(data: GetAllPackagesData) {
        self.storeImg.sd_setImage(with: URL(string: data.storage_logo ?? "")) { img, _, _, _ in
            if let _ = img {
            } else { self.storeImg.image = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)}}
        self.storeNameLbl.text = data.storage_name ?? ""
        self.productCountLbl.text = "\(data.packages_count ?? 0) ta/\(data.packages_count_sold ?? 0) ta"
        self.dateLbl.text = data.created_at_label ?? ""
        self.priceLbl.text = (Int(data.packages_amount ?? "")?.priceFormetter() ?? "0") + " so'm"
        guard let isClosed = data.is_closed else {return}
        if isClosed {
            containerView.backgroundColor = UIColor(named: "success200")
        } else {
            containerView.backgroundColor = .white
        }
        
    }
}
