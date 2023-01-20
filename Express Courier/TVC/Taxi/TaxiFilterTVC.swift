
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
        if from != "Viloyat, tuman" {
            self.fromImg.isHidden = false
        } else {
            self.fromImg.isHidden = true
        }
        
        if to != "Viloyat, tuman" {
            self.toImg.isHidden = false
        } else {
            self.toImg.isHidden = true
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
