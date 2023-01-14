//
//  PaymentTVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class PaymentTVC: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(data: GetTransactionsData) {
        self.nameLbl.text = data.comment ?? ""
        self.dateLbl.text = data.created_at_label ?? ""
        
        if data.type == "plus" {
            self.priceLbl.textColor = UIColor(named: "success400")
            self.priceLbl.text = "\((data.amount ?? 0)) so'm"
        } else {
            self.priceLbl.textColor = UIColor(named: "danger300")
            self.priceLbl.text = "-\(data.amount ?? 0) so'm"
        }
      
    }
}
