
//  KuryerVC.swift
//  Express Courier
//  Created by Sherzod on 09/01/23.

import UIKit
import SwiftPhoneNumberFormatter

class KuryerVC: UIViewController {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var phoneNumberTf: PhoneFormattedTextField!
    @IBOutlet weak var avtoNumberStack: UIStackView!
    @IBOutlet weak var pravaStack: UIStackView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var passportImage: UIImageView!
    @IBOutlet weak var pravaImage: UIImageView!
    @IBOutlet weak var passportText: UILabel!
    @IBOutlet weak var pravaText: UILabel!
    @IBOutlet weak var editImagePassport: UIImageView!
    @IBOutlet weak var editImagePrava: UIImageView!
    
    var isPassport: Bool = true
    var isCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Kuryer bo'lish"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        avtoNumberStack.isHidden = true
        pravaStack.isHidden = true
        phoneNumberTf.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "+### ## ### ## ##")
        self.editImagePassport.isHidden = true
        self.editImagePrava.isHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        var initialPresentingViewController = self.presentingViewController
            while let previousPresentingViewController = initialPresentingViewController?.presentingViewController {
                initialPresentingViewController = previousPresentingViewController
            }


            if let snapshot = view.snapshotView(afterScreenUpdates: true) {
                initialPresentingViewController?.presentedViewController?.view.addSubview(snapshot)
            }

            initialPresentingViewController?.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @IBAction func checkTapped(_ sender: UIButton) {
        
        isCheck = !isCheck
        if isCheck {
            self.checkImage.image = UIImage(named: "checked-post")
            avtoNumberStack.isHidden = false
            pravaStack.isHidden = false
        } else {
            self.checkImage.image = UIImage(named: "unchecked-post")
            avtoNumberStack.isHidden = true
            pravaStack.isHidden = true
        }
    }
    
    
    @IBAction func passportBtnTapped(_ sender: UIButton) {
        openPicker()
        isPassport = true
        
    }
    
    @IBAction func pravaBtnTapped(_ sender: UIButton) {
        openPicker()
        isPassport = false
    }
    
}

extension KuryerVC {
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openPicker() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK:-- ImagePicker delegate
extension KuryerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            if isPassport {
                self.passportImage.image = pickedImage
                self.editImagePassport.isHidden = false
                self.passportText.text = "Rasm yulandi"
            } else {
                self.editImagePrava.isHidden = false
                self.pravaImage.image = pickedImage
                self.pravaText.text = "Rasm yuklandi"
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
