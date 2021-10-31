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

    let picker = CountryPicker()
    
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
        let vc = OTPVC.getVC(.Main)
        self.push(vc)
    }
    

}

//MARK: Country Picker
extension LoginVC : CountryPickerDelegate{
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        imgFlag.image = flag
    }
    
}
