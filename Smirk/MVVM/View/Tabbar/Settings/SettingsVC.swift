//
//  SettingsVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import SwiftUI

class SettingsVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let textArray = ["Personal Info","Matches","Profile Settings","Your Photos","Terms & Conditions","Privacy Policy","Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func btnEditProfileImgAction(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
               //here is the image
            //self.imgData = image.jpegData(compressionQuality: 0.75)
            self.imgProfile.image = image
            print("imhgafe:-",image.jpegData(compressionQuality: 0.2))
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.updateProfileImg(imgData: image.jpegData(compressionQuality: 0.2) ?? Data())
            }
        }
        //https://smirkapp.us/storage/profile_photos/fE4HMOqWiUgQHG55BSz6aDePck8ErAbQrsInPUdB.jpg
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        logout()
    }
    
    func logout(){
        let app = UIApplication.shared.delegate as! AppDelegate
        let vc = LoginVC.getVC(.Main)
        navigationController?.pushViewController(vc, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        app.window?.rootViewController = navigationController
        app.window?.makeKeyAndVisible()
    }
    
}

//MARK:- TableView Delegate and Datasource
extension SettingsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTblCell
        cell.lblTitle.text = textArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
       
        
        switch textArray[indexPath.row]{
            
        case "Personal Info":
            let vc = ProfileInfoVC.getVC(.Setting)
            vc.delegate = self
            self.push(vc)
            
            break
        case "Matches":
            let vc = MatchesVC.getVC(.Setting)
            self.push(vc)
            
            break
        case "Profile Settings":
            let vc = ProfileSettingVC.getVC(.Setting)
            vc.delegate = self
            self.push(vc)
            
            break
        case "Your Photos":
            let vc = PhotosVC.getVC(.Setting)
            vc.delegate = self
            self.push(vc)
            
            break
        case "Help":
            let vc = HelpVC.getVC(.Setting)
            self.push(vc)
            
            break
            
        default:
            print("default value")
            
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}

//MARK: Did update protocol
extension SettingsVC : ProfileUpdateDelagte{
    func didProfileUpdate() {
        self.getUserDetail()
    }
}

//MARK: API
extension SettingsVC{
    
    func getUserDetail(){
        UserVM.shared.getUserDetail { [weak self] (success,msg) in
            if success{
                self?.listAPI()
                print("\("https://smirkapp.us/storage/" + UtilityManager.shared.userDecodedDetail().profile_photo)")
                UtilityManager.shared.setImage(image: self?.imgProfile ?? UIImageView(), urlString: "https://smirkapp.us/storage/" + UtilityManager.shared.userDecodedDetail().profile_photo)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func listAPI(){
        UserVM.shared.retrieveList { [weak self] (success,msg) in
            if success{
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func updateProfileImg(imgData:Data){
        UserVM.shared.uploadProfileImage(imgData: imgData, fileName: "profile_photo") { [weak self] (success,msg) in
            if success{
                self?.getUserDetail()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
        
        
    }
    
}
