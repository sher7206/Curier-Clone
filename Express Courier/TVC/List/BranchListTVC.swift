
//  BranchListTVC.swift
//  Express Courier
//  Created by apple on 14/01/23.

import UIKit

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
    
    
}
