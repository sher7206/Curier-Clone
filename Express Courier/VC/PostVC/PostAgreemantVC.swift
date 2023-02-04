
//  PostAgreemantVC.swift
//  Express Courier
//  Created by apple on 07/01/23.

import UIKit

protocol PostAgreemantVCDelegate{
    func dataUpdater()
}

class PostAgreemantVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var orderTxtLbl: UILabel!
    
    var id = 0
    var delegate: PostAgreemantVCDelegate?
    
    var isCancelled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAnimetion()
        if isCancelled {
            orderTxtLbl.text = "pochta_desc22".localized
        } else {
            orderTxtLbl.text = "pochta_buyurtma1".localized
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        backView.clipsToBounds = true
    }
    
    func apiResponse(id: Int){
        Loader.start()
        let service = PostService()
        service.acceptPostResponse(model: PostAcceptRequest(id: id)) { [self] result in
            switch result {
            case.success:
                Loader.stop()
                delegate?.dataUpdater()
                dismissFunc()
            case.failure(let error):
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
                dismissFunc()
            }
        }
    }
    
    func getReturnOrderCancelled(id: Int) {
        let service = PostService()
        Loader.start()
        service.returnOrderData(model: ReturnPostRequest(id: id)) { [self] result in
            switch result{
            case.success(let content):
                Alert.showAlert(forState: .success, message: content.message ?? "Succes", vibrationType: .success)
                delegate?.dataUpdater()
                dismissFunc()
                Loader.stop()
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
    
    
    @IBAction func dissmissBtnPressed(_ sender: Any) {
        dismissFunc()
    }
    
    
    @IBAction func agreemantBtnPressed(_ sender: Any) {
        if isCancelled{
            getReturnOrderCancelled(id: id)
        }else{
            apiResponse(id: id)
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissFunc()
    }
}
