
//  TaxiFilterTVC.swift
//  Express Courier

import UIKit

protocol TaxiFilterTVCDelegate {
    func fromRegionTapped()
    func toRegionTapped()
    func fromCloseTapped()
    func toCloseTapped()
    func replaceTapped()
}


class TaxiFilterTVC: UITableViewCell {
    
    @IBOutlet weak var fromRegionLbl: UILabel!
    @IBOutlet weak var toRegionLbl: UILabel!
    @IBOutlet weak var fromImg: UIButton!
    @IBOutlet weak var toImg: UIButton!
    
    
    static let identifier = "TaxiFilterTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    var delegate: TaxiFilterTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func updateCell(from: String, to: String, fromRegionId: Int?, toRegionId: Int?) {
        fromRegionLbl.text = from
        toRegionLbl.text = to
        
        if fromRegionId == nil {
            self.fromImg.isHidden = true
        } else {
            self.fromImg.isHidden = false
        }
        
        if toRegionId == nil {
            self.toImg.isHidden = true
        } else {
            self.toImg.isHidden = false
        }
    }
    
    
    @IBAction func fromRegionBtnTapped(_ sender: UIButton) {
        self.delegate?.fromRegionTapped()
    }
    
    @IBAction func toRegionBtnTapped(_ sender: UIButton) {
        self.delegate?.toRegionTapped()
    }
    
    @IBAction func fromCloseBtnTapped(_ sender: UIButton) {
        self.delegate?.fromCloseTapped()
    }
    
    @IBAction func toCloseBtnTapped(_ sender: UIButton) {
        self.delegate?.toCloseTapped()
    }
    
    @IBAction func replaceBtnTapped(_ sender: UIButton) {
        self.delegate?.replaceTapped()
    }
    
}
