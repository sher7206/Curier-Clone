//
//  ItemCVC.swift
//  Express Courier
//
//  Created by apple on 16/01/23.
//

import UIKit

class ItemCVC: UICollectionViewCell {

    static let identifier = "ItemCVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var itemLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
