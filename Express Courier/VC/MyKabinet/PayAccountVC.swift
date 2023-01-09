//
//  PayAccountVC.swift
//  Express Courier
//
//  Created by Sherzod on 06/01/23.
//

import UIKit

class PayAccountVC: UIViewController {
    
    
    @IBOutlet var tfView: [UIView]!
    @IBOutlet weak var priceTf: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var paymeBtn: UIButton!
    @IBOutlet weak var clickBtn: UIButton!
    
    
    var payCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        priceTf.delegate = self
        confirmBtn.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(false)
    }
    
    func setupNavigation() {
        title = "Hisobni to‘ldirish"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
}

extension PayAccountVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfView[0].layer.borderWidth = 1
        tfView[0].layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if priceTf.text! != "" {
            tfView[0].layer.borderWidth = 1
            tfView[0].layer.borderColor = UIColor.black.cgColor
        } else {
            tfView[0].layer.borderWidth = 1
            tfView[0].layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBAction func changePrice(_ sender: UITextField) {
        sender.text!.removeAll { !("0"..."9" ~= $0) }
        let text = sender.text!
        for index in text.indices.reversed() {
            if text.distance(from: text.endIndex, to: index).isMultiple(of: 3) &&
                index != text.startIndex &&
                index != text.endIndex {
                sender.text!.insert(" ", at: index)
            }
        }
        tfView[0].layer.borderWidth = 1
        tfView[0].layer.borderColor = UIColor.black.cgColor
    }
}
