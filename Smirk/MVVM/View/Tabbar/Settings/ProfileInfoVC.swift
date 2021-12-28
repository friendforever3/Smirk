//
//  ProfileInfoVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class ProfileInfoVC: UIViewController {

    @IBOutlet weak var tfFavShow: UITextView!
    @IBOutlet weak var tfAbout: UITextView!
    @IBOutlet weak var tfGender: TextFieldCustom!
    @IBOutlet weak var tfDOB: TextFieldCustom!
    @IBOutlet weak var tfName: TextFieldCustom!
    
    let datePicker = UIDatePicker()
    let genderPickerView = UIPickerView()
    let showPickerView = UIPickerView()
    var gender = ["Male","Female","Non Binary"]
    var selectedGender = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        [genderPickerView,showPickerView].forEach { (pickrVw) in
            pickrVw.delegate = self
            pickrVw.dataSource = self
        }
        tfGender.inputView = genderPickerView
        tfFavShow.inputView = showPickerView
        showDatePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setUI()
    }
    
    func setUI(){
        tfName.text = UserVM.shared.objUserDetailModel.full_name
       
        tfAbout.text = UserVM.shared.objUserDetailModel.about
        
        if UserVM.shared.objUserDetailModel.gender == 0{
            tfGender.text = "Male"
            selectedGender = "0"
        }else if UserVM.shared.objUserDetailModel.gender == 1{
            tfGender.text = "Female"
            selectedGender = "1"
        }else{
            tfGender.text = "Non Binary"
            selectedGender = "2"
        }
        
        tfDOB.text = UtilityManager.shared.getDate(dateString: UserVM.shared.objUserDetailModel.date_of_birth, inputDateformat: "dd/MM/yyyy", outputDateFormate: "MM/dd/yyyy")
        
        for (index,value) in UserVM.shared.objUserDetailModel.user_shows.enumerated(){
            
            if index == 0{
                tfFavShow.text = value.title
            }else{
                tfFavShow.text += ", " + value.title
            }
            
        }
        
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        updateProfile()
    }
    

}

//MARK: PickerView Delegate and datasource
extension ProfileInfoVC:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == genderPickerView{
           return 1 // number of session
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerView{
          return gender.count // number of dropdown items
        }
        return UserVM.shared.shows.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPickerView{
          return gender[row] // dropdown item
        }
        return UserVM.shared.shows[row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPickerView{
          tfGender.text = gender[row]
            if tfGender.text == "Male"{
                selectedGender = "0"
            }else if tfGender.text == "Female"{
                selectedGender = "1"
            }else{
                selectedGender = "2"
            }
        }else{
            tfFavShow.text += ", " + UserVM.shared.shows[row].title
        }
        
    }
    
}


//MARK: Datepicker
extension ProfileInfoVC{
    
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
       formatter.dateFormat = "MM/dd/yyyy"
          tfDOB.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
}

//MARK: API
extension ProfileInfoVC{
    
    func updateProfile(){
        
        UserVM.shared.updateProfileInfo(name: tfName.text ?? "", dob: tfDOB.text ?? "", gender: selectedGender, about: tfAbout.text ?? "", show: UserVM.shared.shows.map({$0.id})) { [weak self] (success,msg) in
            
            
        }
        
    }
    
}
