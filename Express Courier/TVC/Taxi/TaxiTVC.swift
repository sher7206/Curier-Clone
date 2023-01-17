//
//  TaxiTVC.swift
//  Express Courier
//
//  Created by Sherzod on 11/01/23.
//

import UIKit

class TaxiTVC: UITableViewCell {
    
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var valyutaLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var fromDistrictLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var toDistrictlbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var peopleCountLbl: UILabel!
    @IBOutlet weak var seatLbl: UILabel!
//    @IBOutlet weak var viewsCountLbl: UILabel!
    @IBOutlet weak var book_front_seat: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        topStack.constant = 0
        setupViews()
    }
    
    func setupViews() {
        containerView.layer.cornerRadius = 8
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    
    func updateCell(data: GetNewsTaxiData?, index: Int) {
        guard let date = data?.created_at else {return}

        priceLbl.text = "\(data?.cost?.priceFormetter() ?? "")"
        userImage.sd_setImage(with: URL(string: data?.creator_avatar ?? ""))
        fromRegionLbl.text = (data?.from_region_name ?? "") + ", " + (data?.to_district_name ?? "")
        fromDistrictLbl.text = data?.from_address ?? ""
        toRegionLbl.text = (data?.to_region_name ?? "") + ", " + (data?.to_district_name ?? "")
        toDistrictlbl.text = data?.to_address ?? ""
        descLbl.text = data?.note ?? ""
        numberLbl.text = "\(data?.id ?? 0)"
        peopleCountLbl.text = String(data?.seat_count ?? 0)
        userName.text = data?.creator_name ?? ""
        dateLbl.text = String(date.prefix(10))
        
        guard let book_front = data?.book_front_seat else {return}
        if book_front {
            self.book_front_seat.isHidden = false
        } else {
            self.book_front_seat.isHidden = true
        }
    }
}
