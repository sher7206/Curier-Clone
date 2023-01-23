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
    
    func updateCell(data: ListPackagesData) {
        guard let createDate = data.created_at else {return}
        guard let expiredDate = data.expired_at else {return}
        self.dateLbl.text = String(createDate.prefix(10))
        self.priceLbl.text = data.delivery_fee_amount?.priceFormetter()
        self.nameLbl.text = data.matter ?? ""
        self.idlbl.text = "\(data.id ?? 0)"
        self.arrivingTimeLbl.text = String(expiredDate.prefix(10))
        self.senderLbl.text = data.driver_name ?? ""
    }
}
