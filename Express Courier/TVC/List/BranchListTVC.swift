//
//  BranchListTVC.swift
//  Express Courier
//
//  Created by apple on 14/01/23.
//

import UIKit

class BranchListTVC: UITableViewCell {

    static let identifier = "BranchListTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
