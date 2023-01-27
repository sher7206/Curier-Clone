//
//  BranchesTVC.swift
//  Express Courier
//
//  Created by Sherzod on 19/01/23.
//

import UIKit

class BranchesTVC: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(data: BranchData) {
        self.imgV.sd_setImage(with: URL(string: data.logo ?? "")) { img, _, _, _ in
            if let _ = img {
                print("Yuklandi!")
            } else { self.imgV.image = UIImage(named: "no-pictures")?.withTintColor(.black, renderingMode: .alwaysOriginal)}}
        self.nameLbl.text = data.name ?? ""
        self.regionLbl.text = (data.region?.name ?? "") + ", " + (data.district?.name ?? "")
        self.phoneLbl.text = data.call_center ?? ""
    }
}
