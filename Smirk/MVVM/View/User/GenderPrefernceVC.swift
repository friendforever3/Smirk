//
//  GenderPrefernceVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class GenderPrefernceVC: UIViewController {
    @IBOutlet weak var btnMale: ButtonCustom!
    @IBOutlet weak var btnFemale: ButtonCustom!
    @IBOutlet weak var btnNonBinary: ButtonCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if RegisterModel.shared.matching_id == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMatchWith, control: ["OK"], topController: self)
        }else{
            pushAgeDist()
        }
    }
    
    func pushAgeDist(){
        let vc = AgeDistancePrefncVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
   
    @IBAction func btnMaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnMale)
        RegisterModel.shared.matching_id = MatchWith.Male.rawValue
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnFemale)
        RegisterModel.shared.matching_id = MatchWith.Female.rawValue
    }
    
    @IBAction func btnNonBinaryAction(_ sender: Any) {
        selectedVw(selectedBtn: btnNonBinary)
        RegisterModel.shared.matching_id = MatchWith.NonBinary.rawValue
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
