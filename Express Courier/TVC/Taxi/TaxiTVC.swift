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
    @IBOutlet weak var viewsCountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    func setupViews() {
        containerView.layer.cornerRadius = 8
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func updateCell() {
        
    }
}
