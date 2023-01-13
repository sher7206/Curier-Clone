
//  ArrivedItemTVC.swift
//  Express Courier
//  Created by apple on 11/01/23.

import UIKit

class ArrivedItemTVC: UITableViewCell {
    
    
    static let identifier = "ArrivedItemTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}

    @IBOutlet weak var tickImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
