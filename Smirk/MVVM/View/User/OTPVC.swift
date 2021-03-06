//
//  OTPVC.swift
//  Smirk
//
//  Created by Surinder kumar on 29/10/21.
//

import UIKit

class OTPVC: UIViewController {

    @IBOutlet weak var tfone: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThird: UITextField!
    @IBOutlet weak var tfForth: UITextField!
    @IBOutlet weak var tfFifth: UITextField!
    
    var mobile : String = ""
    var otpString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegate()
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if tfone.text?.isEmptyOrWhitespace() ??  false || tfTwo.text?.isEmptyOrWhitespace() ?? false || tfThird.text?.isEmptyOrWhitespace() ?? false || tfForth.text?.isEmptyOrWhitespace() ?? false{
            
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kOTP, control: ["OK"], topController: self)
            
        }else{
            RegisterModel.shared.mobile = mobile
            self.submitOTP()
        }
        
        
       // self.pushToLaugh()
    }
    
    

}


//MARK:- textField Delegate
extension OTPVC: UITextFieldDelegate{
    
    func setDelegate(){
        let txtflds = [tfone,tfTwo,tfThird,tfForth,tfFifth]
        
        txtflds.forEach { txtfld in
            txtfld?.delegate = self
            txtfld?.keyboardType = .numberPad
        }
    
        self.tfone.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfTwo.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfThird.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfForth.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfFifth.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
       
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        otpString = ""
        if (text?.utf16.count)! >= 1{
            switch textField{
            case tfone:
                tfTwo.becomeFirstResponder()
            case tfTwo:
                tfThird.becomeFirstResponder()
            case tfThird:
                tfForth.becomeFirstResponder()
            case tfForth:
                tfFifth.resignFirstResponder()
            case tfFifth:
                tfFifth.resignFirstResponder()
            
            default:
                break
            }
            otpString = "\(tfone.text ?? "")\(tfTwo.text ?? "")\(tfThird.text ?? "")\(tfForth.text ?? "")\(tfFifth.text ?? "" )"
        }
        if (text?.utf16.count)! == 0 {
            switch textField{
            case tfone:
                tfone.becomeFirstResponder()
            case tfTwo:
                tfone.becomeFirstResponder()
            case tfThird:
                tfTwo.becomeFirstResponder()
            case tfForth:
                tfThird.becomeFirstResponder()
            case tfFifth:
                tfForth.becomeFirstResponder()
            
            default:
                break
            }
            
        }else{
            
        }
    }
    
}

//MARK: API
extension OTPVC{
    
    func submitOTP(){
        let otp = (tfone.text ?? "") + (tfTwo.text ?? "") + (tfThird.text ?? "") + (tfForth.text ?? "")
        UserVM.shared.submitOtpApi(mobileNo: mobile, otp: otp) { [weak self] (succcess,msg) in
            if succcess{
                if UtilityManager.shared.userDecodedDetail().is_registered == 0{
                    self?.pushToLaugh()
                }else{
                    self?.pushToHome()
                }
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func pushToLaugh(){
        let vc = LaughVC.getVC(.Main)
        self.push(vc)
    }
    
    func pushToHome(){
        let vc = SmirkTabbarVC.getVC(.SmirkTabbar)
        self.push(vc)
    }
    
}
