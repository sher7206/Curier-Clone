//
//  PostInsideTVC.swift
//  Express Courier
//
//  Created by apple on 06/01/23.
//

import UIKit

class PostInsideTVC: UITableViewCell {

    static let identifier = "PostInsideTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var contView: UIView!{
        didSet{
            contView.layer.shadowColor = #colorLiteral(red: 0.3568627451, green: 0.3568627451, blue: 0.3568627451, alpha: 1).cgColor
            contView.layer.shadowRadius = 5
            contView.layer.shadowOpacity = 1
            contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    @IBOutlet weak var matterLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var fromAdressLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var toAdressLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var arrivingDateLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
