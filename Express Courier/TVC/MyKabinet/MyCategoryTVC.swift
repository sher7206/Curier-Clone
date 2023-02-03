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
        chevronImage.image = UIImage(systemName: "chevron.right")
        self.nameLbl.text = dates[index].name
        if index == 1 || index == 8 {
            chevronImage.image = UIImage(named: "processing")?.withTintColor(UIColor(named: "primary900")!, renderingMode: .alwaysOriginal)
        }
        if index == 9 || index == 10 {
            chevronImage.image = nil
        }
        
        if index == 10 {
            self.nameLbl.textColor = UIColor(named: "danger300")
            self.bottomView.isHidden = true
        } else {
            self.nameLbl.textColor = .black
            self.bottomView.isHidden = false
        }
    }
}
