//
//  DisttributionTVC.swift
//  Express Courier
//
//  Created by apple on 17/01/23.
//

import UIKit

class DisttributionTVC: UITableViewCell {

    static let identifier = "DisttributionTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var arrivingTimeLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
