
//  PostAgreemantVC.swift
//  Express Courier
//  Created by apple on 07/01/23.

import UIKit

protocol PostAgreemantVCDelegate{
    func dataUpdater()
}
class PostAgreemantVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    var id = 0
    var delegate: PostAgreemantVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAnimetion()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        backView.clipsToBounds = true
    }

    func apiResponse(id: Int){
        let service = PostService()
        service.acceptPostResponse(model: PostAcceptRequest(id: id)) { [self] result in
            switch result{
            case.success(let content):
                Alert.showAlert(forState: .success, message: content.message ?? "Ok", vibrationType: .success)
                delegate?.dataUpdater()
                dismissFunc()
            case.failure(let error):
                Alert.showAlert(forState: .error, message: error.message ?? "Error", vibrationType: .error)
                dismissFunc()
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
        apiResponse(id: id)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissFunc()
    }
    
    
}
