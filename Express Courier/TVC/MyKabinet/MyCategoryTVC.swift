//
//  MyCategoryTVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

struct MyKabinetCategoryDM{
    var name: String
    var imgName: String
}

class MyCategoryTVC: UITableViewCell {

    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(dates: [MyKabinetCategoryDM], index: Int) {
        self.nameImage.image = UIImage(named: dates[index].imgName)
        self.nameLbl.text = dates[index].name
        
        if index == 9 {
            chevronImage.image = nil
        } else {
            chevronImage.image = UIImage(systemName: "chevron.right")
        }
        if index == 9 {
            self.bottomView.isHidden = true
        } else {
            self.bottomView.isHidden = false
        }
    }
}
