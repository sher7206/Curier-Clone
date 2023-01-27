//
//  ReportTVC.swift
//  Express Courier
//
//  Created by apple on 16/01/23.
//

import UIKit
import SDWebImage

class ReportTVC: UITableViewCell {
    
    static let identifier = "ReportTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(data: StatsPackagesData) {
        self.imgV.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgV.sd_setImage(with: URL(string: data.icon ?? "")) { img, _, _, _ in
            if let _ = img {
            } else { self.imgV.image = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)}}
        self.textLbl.text = data.label ?? ""
        self.priceLbl.text = "\(data.value ?? 0)"
    }
    
}
