
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
    
    static let identifier = "TaxiFilterTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    var delegate: TaxiFilterTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func updateCell(from: String, to: String) {
        fromRegionLbl.text = from
        toRegionLbl.text = to
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
