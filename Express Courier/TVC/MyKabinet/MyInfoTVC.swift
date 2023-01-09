//
//  MyInfoTVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class MyInfoTVC: UITableViewCell {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personPhoneNumber: UILabel!
    @IBOutlet weak var personId: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var shotLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell() {
        
    }
}
