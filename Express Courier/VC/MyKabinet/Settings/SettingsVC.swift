//
//  SettingsVC.swift
//  Express Courier
//
//  Created by Sherzod on 07/01/23.
//

import UIKit
import SDWebImage

class SettingsVC: UIViewController {
    
    @IBOutlet weak var persinImgV: UIImageView!
    @IBOutlet var langImage: [UIImageView]!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var regionTf: UITextField!
    @IBOutlet weak var districtTf: UITextField!
    var regionId: Int = 0
    var districtId: Int = 0
    let user = Cache.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        title = "Ma’lumotlarni o‘zgaritirish"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        langImage[0].image = UIImage(named: "radiobutton-checked-my")
        uploadUpdate()
    }
    
    func uploadUpdate() {
        persinImgV.sd_setImage(with: URL(string: user?.avatar ?? "")) { img,_,_,_ in
            if let _ = img {
                print("yuklandi")
            } else {
                self.persinImgV.image = UIImage(systemName: "person")?.withTintColor(UIColor(named: "black700")!, renderingMode: .alwaysOriginal)
            }
        }
        nameTf.text! = user?.name ?? ""
        lastNameTf.text! = user?.surname ?? ""
        regionTf.text! = (user?.region_name ?? "Viloyat") + ", " + (user?.district_name ?? "tuman")
        districtTf.text! = user?.detail_address ?? ""
        regionId = user?.region_id ?? 0
        districtId = user?.district_id ?? 0
    }
    
    @IBAction func changeAvatarTapped(_ sender: UIButton) {
        openPicker()
    }
    
    
    @IBAction func regionSelectTapped(_ sender: UIButton) {
        let vc = RegionsVC()
        vc.vc = self
        self.present(vc, animated: true)
    }
    
    @IBAction func languageBtnTapped(_ sender: UIButton) {
        for i in langImage {
            i.image = UIImage(named: "radiobutton-unchecked-my")
        }
        langImage[sender.tag].image = UIImage(named: "radiobutton-checked-my")
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        Loader.start()
        let updateUser = UserService()
        
        guard let dataImg = self.persinImgV.image?.sd_resizedImage(with: CGSize(width: 400, height: 400), scaleMode: .aspectFill)?.pngData() else { return  }
        
        updateUser.updateUser(imgData: dataImg, avatar: "avatar", name: nameTf.text!, surname: lastNameTf.text!, region_id: regionId, district_id: districtId, detail_address: districtTf.text!) { result in
            switch result {
            case.success(let content):
                guard let data = content.data else {return}
                var user = UserDM()
                user.id = data.id
                user.name = data.name
                user.surname = data.surname
                user.email = data.email
                user.balance = data.balance
                user.rating = data.rating
                user.region_id = data.region_id
                user.region_name = data.region_name
                user.district_id = data.district_id
                user.district_name = data.district_name
                user.detail_address = data.detail_address
                user.avatar = data.avatar
                user.roles = data.roles
                user.created_at = data.created_at
                user.created_at_label = data.created_at_label
                user.phone = data.phone
                Cache.saveUser(user: user)
                Loader.stop()
                self.navigationController?.popViewController(animated: true)
            case.failure(let error):
                print(error.localizedDescription)
                Loader.stop()
                Alert.showAlert(forState: .error, message: error.localizedDescription, vibrationType: .error)
            }
        }
    }
}

extension SettingsVC: RegionSelectedVCDelegate {
    func setLocatoin(region id: Int, regoin name: String, state: States, isToRegion: Bool) {
        regionTf.text! = name + ", " + state.name
        self.regionId = id
        self.districtId = state.id ?? 0
    }
}


extension SettingsVC {
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
        let alert = UIAlertController(title: "Rasm tanlang", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Orqaga", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK:-- ImagePicker delegate
extension SettingsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.persinImgV.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
