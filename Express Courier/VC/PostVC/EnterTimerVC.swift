
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

protocol EnterTimerVCDelegate{
    func dismissOrder()
}

class EnterTimerVC: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datetf: UITextField!
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
    
    var id = 0
    var delegate: EnterTimerVCDelegate?
    let datePicker = UIDatePicker()
    var orderType: OrderReason = .taymer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.text! = "pochta_bekor_qilish3".localized
        openAnimetion()
        showDatePicker()
        orderTypeReader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        contView.clipsToBounds = true
    }
    
    func orderTypeReader(){
        switch orderType {
        case .taymer:
            hiddenStack.isHidden = false
            reasonLbl.text = "pochta_taymer3".localized
            viewNameLbl.text = "pochta_taymer1".localized
            confirmationLbl.text = "pochta_taymer4".localized
        case .takeOrder:
            hiddenStack.isHidden = true
            reasonLbl.text = "pochta_buyurtma_olish2".localized
            viewNameLbl.text = "pochta_buyurtma_olish1".localized
            confirmationLbl.text = "pochta_buyurtma_olish3".localized
        case .cancelOrder:
            hiddenStack.isHidden = true
            reasonLbl.text = "pochta_bekor_qilish2".localized
            viewNameLbl.text = "pochta_bekor_qilish1".localized
            confirmationLbl.text = "pochta_bekor_qilish4".localized
        case .overOrder:
            hiddenStack.isHidden = true
            reasonLbl.text = "pochta_yetkazish2".localized
            viewNameLbl.text = "pochta_yetkazish1".localized
            confirmationLbl.text = "pochta_yetkazish3".localized
        }
    }
    
    func cancelOrderPatch(reason: String){
        let service = PostService()
        Loader.start()
        service.cancelOrderPostData(model: CancelOrderPostRequest(id: id, reason: reason)) { [self] result in
            switch result{
            case.success(let content):
                Loader.stop()
                Alert.showAlert(forState: .success, message: content.message ?? "Success", vibrationType: .success)
                delegate?.dismissOrder()
                dismissFunc()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }

    func confirmOrderPatch(reason: String){
        let service = PostService()
        Loader.start()
        service.confirmOrderPostData(model: ConfirmPostRequest(id: id, reason: reason)) { [self] result in
            switch result{
            case.success(let content):
                Loader.stop()
                Alert.showAlert(forState: .success, message: content.message ?? "Success", vibrationType: .success)
                delegate?.dismissOrder()
                dismissFunc()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }

    func takeOrderPatch(reason: String){
        let service = PostService()
        Loader.start()
        service.takeOrderData(model: TakeOrderPostRequest(id: id, reason: reason)) { [self] result in
            switch result{
            case.success(let content):
                Loader.stop()
                Alert.showAlert(forState: .success, message: content.message ?? "Success", vibrationType: .success)
                delegate?.dismissOrder()
                dismissFunc()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
    
    func enterTimerOrderPatch(reason: String, date: String){
        let service = PostService()
        Loader.start()
        service.enterTimerOrderData(model: TimerOrderPostRequest(id: id, reason: reason, date: date)) { [self] result in
            switch result{
            case.success(let content):
                Loader.stop()
                Alert.showAlert(forState: .success, message: content.message ?? "Success", vibrationType: .success)
                delegate?.dismissOrder()
                dismissFunc()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
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

        
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        dismissFunc()
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if textView.text.isEmpty{
            Alert.showAlert(forState: .error, message: "pochta_taymer6".localized, vibrationType: .error)
        }else{
            switch orderType {
            case .taymer:
                if datetf.text!.isEmpty{
                    Alert.showAlert(forState: .error, message: "pochta_taymer5".localized, vibrationType: .error)
                }else{
                    enterTimerOrderPatch(reason: textView.text, date: datetf.text!)
                }
            case .takeOrder:
                takeOrderPatch(reason: textView.text)
            case .cancelOrder:
                cancelOrderPatch(reason: textView.text)
            case .overOrder:
                confirmOrderPatch(reason: textView.text)
            }
        }

    }
    
}


//MARK: - Date Picker
extension EnterTimerVC {
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "pochta_taymer7".localized, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "pochta_taymer8".localized, style: .plain, target: self, action: #selector(cancelDatePicker));
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datetf.inputAccessoryView = toolbar
        datetf.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        datetf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            self.datetf.text! = "\(year)-\(month)-\(day)"
        }
    }
}


extension EnterTimerVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.text.removeAll()
    }
}




