//
//  ProfileSettingVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import RangeSeekSlider

struct ChoiceModel{
    
    var id : String?
    var name : String?
    
}

class ProfileSettingVC: UIViewController {

    @IBOutlet weak var tfPreEthenicity: UITextView!
    @IBOutlet weak var tfMaxDistance: TextFieldCustom!
    @IBOutlet weak var rangeSlidr: RangeSeekSlider!
    @IBOutlet weak var tfDOB: TextFieldCustom!
    @IBOutlet weak var tfName: TextFieldCustom!
    
    let laughWithPickerView = UIPickerView()
    let InterestedInPickerView = UIPickerView()
    let maxDistancePickerView = UIPickerView()
    let prefEthenicityPickerView = UIPickerView()
    
    var laughtWithArray = [["name":"Just Friends","id":"1"],["name":"Romantic Interest","id":"2"]]
    var interestedInArray = [["name":"Male","id":"1"],["name":"Female","id":"2"],["name":"Non Binary","id":"3"]]
    var maxDistArray = ["10","50","100","Any"]
    
    var laughId : String = ""
    var interestedID : String = ""
    var prefEthncityId = [Int]()
    var delegate : ProfileUpdateDelagte?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        [laughWithPickerView,InterestedInPickerView,maxDistancePickerView].forEach { (pickerVw) in
            pickerVw.delegate = self
            pickerVw.dataSource = self
        }
        
        [tfName,tfDOB,tfMaxDistance,tfPreEthenicity].forEach { (txtFld) in
            if let txt = txtFld as? UITextField{
                txt.delegate = self
            }
            
            if let txtView = txtFld as? UITextView{
                txtView.delegate = self
            }
        }
        
        tfName.inputView = laughWithPickerView
        tfDOB.inputView = InterestedInPickerView
        tfMaxDistance.inputView = maxDistancePickerView
        //tfPreEthenicity.inputView = prefEthenicityPickerView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setUI()
    }
    
    func setUI(){
        
        if UserVM.shared.getLaughId() == "1"{
            tfName.text = "Just Friend"
            laughId = "1"
        }else{
            tfName.text = "Romantic Interest"
            laughId = "2"
        }
        
        if UserVM.shared.getInterestedId() == "1"{
            tfDOB.text = "Male"
            interestedID = "1"
        }else if UserVM.shared.getInterestedId() == "2"{
            tfDOB.text = "Female"
            interestedID = "2"
        }else{
            tfDOB.text = "Non Binary"
            interestedID = "3"
        }
        
        rangeSlidr.selectedMinValue = UserVM.shared.getAgeRange().from.CGFloatValue() ?? 0.0
        
        rangeSlidr.selectedMaxValue = UserVM.shared.getAgeRange().To.CGFloatValue() ?? 0.0
        
        tfMaxDistance.text = UserVM.shared.getMaxDistance()
        prefEthncityId.removeAll()
        for (index,value) in UserVM.shared.getPrefEthncity().enumerated(){
            
            if index == 0{
                tfPreEthenicity.text = value.title
            }else{
                tfPreEthenicity.text += ", " + value.title
            }
            prefEthncityId.append(value.id)
        }
        
        
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        updateProfileSetting()
    }
    
}

//MARK: TextField Delegate
extension ProfileSettingVC : UITextFieldDelegate,UITextViewDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfName{
            if laughtWithArray.count != 0{
                tfName.text = laughtWithArray[0]["name"]
                laughId = laughtWithArray[0]["id"] ?? ""
            }
        }else if textField == tfDOB{
            if interestedInArray.count != 0{
                tfDOB.text = interestedInArray[0]["name"]
                interestedID = interestedInArray[0]["id"] ?? ""
            }
        }else if textField == tfMaxDistance{
            if maxDistArray.count != 0{
                tfMaxDistance.text = maxDistArray[0]
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == tfPreEthenicity{
            if UserVM.shared.preferEthicArray.count != 0{
                self.view.endEditing(true)
                let vc = EthnicityPrefrncVC.getVC(.Main)
                self.push(vc)
            }
        }
    }
    
}

//MARK: PickerView Delegate and datasource
extension ProfileSettingVC:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == laughWithPickerView{
          return laughtWithArray.count // number of dropdown items
        }else if pickerView == InterestedInPickerView{
            return interestedInArray.count
        }else if pickerView == maxDistancePickerView{
            return maxDistArray.count
        }
        return UserVM.shared.preferEthicArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == laughWithPickerView{
          return laughtWithArray[row]["name"] // dropdown item
        }else if pickerView == InterestedInPickerView{
            return interestedInArray[row]["name"]
        }else if pickerView == maxDistancePickerView{
            return maxDistArray[row]
        }
        return UserVM.shared.preferEthicArray[row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == laughWithPickerView{
            tfName.text = laughtWithArray[row]["name"]
            laughId = laughtWithArray[row]["id"] ?? ""
        }else if pickerView == InterestedInPickerView{
            tfDOB.text = interestedInArray[row]["name"]
            interestedID = interestedInArray[row]["id"] ?? ""
        }else if pickerView == maxDistancePickerView{
            tfMaxDistance.text = maxDistArray[row]
        }else{
            tfPreEthenicity.text += ", " + UserVM.shared.preferEthicArray[row].title
        }
        
    }
    
}


//MARK: API
extension ProfileSettingVC{
    
    func updateProfileSetting(){

        
        UserVM.shared.updateProfileSetting(laugh_id: laughId, interestedIn: interestedID, rangeFrom: "\(rangeSlidr.selectedMinValue)", rangeTo: "\(rangeSlidr.selectedMaxValue)", maxDist: tfMaxDistance.text ?? "", preEthncity: prefEthncityId) { [weak self] (success,msg) in
            
            if success{
                self?.delegate?.didProfileUpdate()
                UtilityManager.shared.displayAlertWithCompletion(title: "", message: msg, control: ["OK"], topController: self ?? UIViewController()) { (_) in
                    self?.popVc()
                }
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }

    }
    
}
