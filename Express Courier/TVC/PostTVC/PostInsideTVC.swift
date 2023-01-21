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
    
    @IBOutlet weak var headerDateLbl: UILabel!
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
    
    func updateCell(data: GetPostRespnseData){
        matterLbl.text = data.matter ?? ""
        priceLbl.text = "\(data.delivery_fee_amount?.priceFormetter() ?? "")"
        fromRegionLbl.text = "\(data.from_region_name ?? ""), \(data.from_district_name ?? "")"
        fromAdressLbl.text = data.from_address ?? ""
        toRegionLbl.text = "\(data.to_region_name ?? ""), \(data.to_district_name ?? "")"
        toAdressLbl.text = data.to_address ?? ""
        idLbl.text = "\(data.id ?? 0)"
        guard let date = data.expired_at else {return}
        arrivingDateLbl.text = String(date.prefix(10))
        senderLbl.text = data.creator_name ?? ""
        guard let create = data.created_at else {return}
        headerDateLbl.text = String(create.prefix(10))
    }
    
    func updateCellListData(data: ListPackagesData) {
        guard let expiredAt = data.expired_at else {return}
        matterLbl.text = data.matter ?? ""
        priceLbl.text = "\(data.delivery_fee_amount?.priceFormetter() ?? "")"
        fromRegionLbl.text = (data.from_region_name ?? "") + ", " + (data.from_district_name ?? "")
        fromAdressLbl.text = data.from_address ?? ""
        toRegionLbl.text = (data.to_region_name ?? "") + ", " + (data.to_district_name ?? "")
        toAdressLbl.text = data.to_address ?? ""
        idLbl.text = "\(data.id ?? 0)"
        arrivingDateLbl.text = String(expiredAt.prefix(10))
        senderLbl.text = data.creator_name ?? ""
    }
    
    
}
