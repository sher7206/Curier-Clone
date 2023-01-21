
//  SortTVC.swift
//  Express Courier
//  Created by apple on 16/01/23.

import UIKit

class SortTVC: UITableViewCell {

    static let identifier = "SortTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(data: CountPackagesData) {
        self.nameLbl.text = data.label
        self.countLbl.text = "\(data.count ?? 0) ta"
    }

    
}
