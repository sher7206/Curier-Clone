//
//  TaxiHeaderCVC.swift
//  Express Courier
//
//  Created by Sherzod on 11/01/23.
//

import UIKit

class TaxiHeaderCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(title: String) {
        titleLbl.text = title
    }
    
}
