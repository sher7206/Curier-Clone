//
//  OnboardingCVC.swift
//  Express Courier
//
//  Created by Sherzod on 05/01/23.
//

import UIKit

class OnboardingCVC: UICollectionViewCell {
    

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func updateCell(title: String, desc: String, img: String) {
        self.imgV.image = UIImage(named: img)
        self.nameLbl.text! = title
        self.descLbl.text! = desc
    }

}
