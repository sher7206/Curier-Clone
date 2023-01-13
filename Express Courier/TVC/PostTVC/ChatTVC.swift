//
//  ChatTVC.swift
//  Express Courier
//
//  Created by apple on 11/01/23.
//

import UIKit

class ChatTVC: UITableViewCell {

    static let identifier = "ChatTVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
}
