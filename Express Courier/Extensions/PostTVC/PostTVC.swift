
//  PostTVC.swift
//  Express Courier
//  Created by apple on 06/01/23.

import UIKit

class PostTVC: UITableViewCell {

    @IBOutlet weak var matterLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var fromAdressLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var toAdressLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var arrivingDateLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!

    
    static let identifier = "PostTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
}
