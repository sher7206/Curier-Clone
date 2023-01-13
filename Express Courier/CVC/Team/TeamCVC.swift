//
//  TeamCVC.swift
//  Express Courier
//
//  Created by Sherzod on 12/01/23.
//

import UIKit

protocol TeamCVCDelegate {
    func deleteItem(index: Int)
}

class TeamCVC: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    var delegate: TeamCVCDelegate?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell() {
        
    }
    
    
    @IBAction func deleteItemTapped(_ sender: UIButton) {
        self.delegate?.deleteItem(index: self.index)
    }
}
