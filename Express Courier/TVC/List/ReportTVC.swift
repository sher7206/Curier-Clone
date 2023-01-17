//
//  ReportTVC.swift
//  Express Courier
//
//  Created by apple on 16/01/23.
//

import UIKit

class ReportTVC: UITableViewCell {

    static let identifier = "ReportTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
