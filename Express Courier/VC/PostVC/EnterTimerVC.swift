
//  EnterTimerVC.swift
//  Express Courier
//  Created by apple on 12/01/23.


import UIKit

enum OrderReason{
    case taymer
    case takeOrder
    case cancelOrder
    case overOrder
}

class EnterTimerVC: UIViewController {

    @IBOutlet weak var viewNameLbl: UILabel!
    @IBOutlet weak var hiddenStack: UIStackView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var confirmBtn: UIView!
    
    @IBOutlet weak var confirmationLbl: UILabel!
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.layer.shadowColor = UIColor(named: "black500")?.cgColor
            headerView.layer.shadowOpacity = 0.2
            headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.layer.shadowRadius = 1
        }
    }
    
    var orderType: OrderReason = .taymer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAnimetion()
        switch orderType {
        case .taymer:
            hiddenStack.isHidden = false
            reasonLbl.isHidden = true
            viewNameLbl.text = "Taymer kiritish"
            confirmationLbl.text = "Tasdiqlash"
        case .takeOrder:
            hiddenStack.isHidden = true
            reasonLbl.isHidden = false
            reasonLbl.text = "Buyurtmani olib qolishdan maqsad qanaqa edi ?"
            viewNameLbl.text = "Buyurtmani olib qolish"
            confirmationLbl.text = "Tasdiqlash"
        case .cancelOrder:
            hiddenStack.isHidden = true
            reasonLbl.isHidden = false
            reasonLbl.text = "Buyurtmani bekor qilishga sabab nima edi ?"
            viewNameLbl.text = "Buyurtmani bekor qilish"
            confirmationLbl.text = "Tasdiqlash"
        case .overOrder:
            hiddenStack.isHidden = true
            reasonLbl.isHidden = false
            reasonLbl.text = "Jo‘natma mijozga topshirilgan bo‘lsa  yetkazildi tugmasini bosing."
            viewNameLbl.text = "Buyurtmani yakunlash"
            confirmationLbl.text = "Yetkazildi"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        contView.clipsToBounds = true
    }
    
    
    func openAnimetion() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }

    func dismissFunc() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true)
    }

    
    @IBAction func tickBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func calendarBtnPressed(_ sender: Any) {
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        dismissFunc()
    }
    
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
    }
    
}
