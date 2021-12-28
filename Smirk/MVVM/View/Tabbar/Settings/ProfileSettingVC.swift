//
//  ProfileSettingVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import RangeSeekSlider

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
    
    var laughtWithArray = ["Just Friends","Romantic Interest"]
    var interestedInArray = ["Male","Female","Non Binary"]
    var maxDistArray = ["10","50","100","Any"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        [laughWithPickerView,InterestedInPickerView,maxDistancePickerView].forEach { (pickerVw) in
            pickerVw.delegate = self
            pickerVw.dataSource = self
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
        
        if UserVM.shared.objUserDetailModel.laugh_id == "1"{
            tfName.text = "Just Friend"
        }else{
            tfName.text = "Romantic Interest"
        }
        
        if UserVM.shared.objUserDetailModel.matching_id == "1"{
            tfDOB.text = "Male"
        }else if UserVM.shared.objUserDetailModel.matching_id == "1"{
            tfDOB.text = "Female"
        }else{
            tfDOB.text = "Non Binary"
        }
        
        //tfName.text = UserVM.shared.objUserDetailModel.full_name
        //tfDOB.text = UtilityManager.shared.getDate(dateString: UserVM.shared.objUserDetailModel.date_of_birth, inputDateformat: "dd/MM/yyyy", outputDateFormate: "MM/dd/yyyy")
        
        
        rangeSlidr.selectedMinValue = UserVM.shared.objUserDetailModel.age_preference_from.CGFloatValue() ?? 0.0
        
        rangeSlidr.selectedMaxValue = UserVM.shared.objUserDetailModel.age_preference_to.CGFloatValue() ?? 0.0
        
        tfMaxDistance.text = UserVM.shared.objUserDetailModel.max_distance
        
        for (index,value) in UserVM.shared.objUserDetailModel.user_preferences.enumerated(){
            
            if index == 0{
                tfPreEthenicity.text = value.title
            }else{
                tfPreEthenicity.text += ", " + value.title
            }
        }
        
        
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
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
          return laughtWithArray[row] // dropdown item
        }else if pickerView == InterestedInPickerView{
            return interestedInArray[row]
        }else if pickerView == maxDistancePickerView{
            return maxDistArray[row]
        }
        return UserVM.shared.preferEthicArray[row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == laughWithPickerView{
            tfName.text = laughtWithArray[row]
        }else if pickerView == InterestedInPickerView{
            tfDOB.text = interestedInArray[row]
        }else if pickerView == maxDistancePickerView{
            tfMaxDistance.text = maxDistArray[row]
        }else{
            tfPreEthenicity.text += ", " + UserVM.shared.preferEthicArray[row].title
        }
        
    }
    
}
