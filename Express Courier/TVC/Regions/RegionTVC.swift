//
//  RegionTVC.swift
//  100kExpress
//
//  Created by Sherzod on 28/11/22.
//

import UIKit

class RegionTVC: UITableViewCell {
    @IBOutlet weak var textLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(textlbl: String) {
        self.textLbl.text = textlbl
    }
}
