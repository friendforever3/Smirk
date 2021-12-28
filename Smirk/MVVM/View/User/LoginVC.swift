//
//  LoginVC.swift
//  Smirk
//
//  Created by Surinder kumar on 29/10/21.
//

import UIKit
import CountryPicker

class LoginVC: UIViewController {
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var tfCode: TextFieldCustom!
    @IBOutlet weak var tfMobileNo: TextFieldCustom!
    
    let picker = CountryPicker()
    var countryCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
        picker.theme = theme //optional for UIPickerView theme changes
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)
        
        
        tfCode.inputView = picker
        
    }

    @IBAction func btnContinueAction(_ sender: Any) {
        if tfMobileNo.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgMobile, control: ["OK"], topController: self)
        }else{
            login()
        }
        
       // pushToHome()
    }
    

}

//MARK: Country Picker
extension LoginVC : CountryPickerDelegate{
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        imgFlag.image = flag
        self.countryCode = phoneCode
    }
    
}


//MARK: API
extension LoginVC{
    
    func login(){
        let mobileNo = (self.countryCode) + (tfMobileNo.text ?? "")
        UserVM.shared.sendOtpApi(mobileNo: mobileNo) { [weak self] (success,msg) in
            if success{
                self?.pushToOtp()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func pushToOtp(){
         let vc = OTPVC.getVC(.Main)
         vc.mobile = (self.countryCode) + (tfMobileNo.text ?? "")
         self.push(vc)
    }
    
    func pushToHome(){
        let vc = SmirkTabbarVC.getVC(.SmirkTabbar)
        self.push(vc)
    }
    
}
