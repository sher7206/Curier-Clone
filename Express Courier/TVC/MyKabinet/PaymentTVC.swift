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
        guard let date = data.created_at else {return}
        self.nameLbl.text = data.comment ?? ""
        self.dateLbl.text = String(date.prefix(10))
        
        if data.type == "plus" {
            self.priceLbl.textColor = UIColor(named: "success400")
            self.priceLbl.text = "\((data.amount?.priceFormetter()) ?? "") so'm"
        } else {
            self.priceLbl.textColor = UIColor(named: "danger300")
            self.priceLbl.text = "-\((data.amount?.priceFormetter()) ?? "") so'm"
        }
      
    }
}
