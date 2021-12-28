//
//  SetupProfileBioVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import IQKeyboardManager

class SetupProfileBioVC: UIViewController {

    @IBOutlet weak var tfFullName: TextFieldCustom!
    @IBOutlet weak var tfDOB: TextFieldCustom!
    @IBOutlet weak var btnNonBinary: ButtonCustom!
    @IBOutlet weak var btnFemale: ButtonCustom!
    @IBOutlet weak var btnMale: ButtonCustom!
    @IBOutlet weak var tfPreferredNounce: TextFieldCustom!
    @IBOutlet weak var tfAbout: IQTextView!
    
    let datePicker = UIDatePicker()
    var selectedGender : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showDatePicker()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        
        if tfFullName.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgFullName, control: ["OK"], topController: self)
        }else if tfDOB.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgDOB, control: ["OK"], topController: self)
        }else if RegisterModel.shared.gender == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgGender, control: ["OK"], topController: self)
        }else if tfAbout.text.isEmptyOrWhitespace(){
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kAbout, control: ["OK"], topController: self)
        }else{
            
            RegisterModel.shared.full_name = tfFullName.text ?? ""
            RegisterModel.shared.date_of_birth = tfDOB.text ?? ""
            RegisterModel.shared.about = tfAbout.text ?? ""
            
            pushToShow()
            
        }
    }
    
    func pushToShow(){
        let vc = SetupProfileShowVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnMaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnMale)
        RegisterModel.shared.gender = Gender.Male.rawValue
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnFemale)
        RegisterModel.shared.gender = Gender.Female.rawValue
    }
    
    @IBAction func btnNonBianryAction(_ sender: Any) {
        selectedVw(selectedBtn: btnNonBinary)
        RegisterModel.shared.gender = Gender.NonBinary.rawValue
    }
    

    func selectedVw(selectedBtn:ButtonCustom){
        
        let btns = [btnMale,btnFemale,btnNonBinary]

        for btn in btns{
            if btn == selectedBtn{
                btn?.backgroundColor = .white
                btn?.setTitleColor(UIColor(named: "blackColor"), for: .normal)
            }else{
                btn?.backgroundColor = .clear
                btn?.borderColor = .white
                btn?.setTitleColor(.white, for: .normal)
            }
        }
        
    }
    
}

//MARK: Datepicker
extension SetupProfileBioVC{
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        tfDOB.inputAccessoryView = toolbar
        tfDOB.inputView = datePicker

     }

      @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       tfDOB.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
}
